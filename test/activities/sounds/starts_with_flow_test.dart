import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_context.dart';
import 'package:lee_con_leo/activities/common/activity_screen.dart';
import 'package:lee_con_leo/activities/common/widgets/demo_overlay.dart';
import 'package:lee_con_leo/activities/sounds/starts_with_activity.dart';
import 'package:lee_con_leo/core/audio/audio_providers.dart';
import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/content_providers.dart';
import 'package:lee_con_leo/core/content/models/word.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/logging/in_memory_event_log.dart';
import 'package:lee_con_leo/core/logging/logging_providers.dart';
import 'package:lee_con_leo/core/progress/progress_providers.dart';

import '../../fakes/recording_prompt_player.dart';
import '../../fakes/test_content.dart';

void main() {
  group('items', () {
    final items = const StartsWithActivity().buildItems(
      ActivityContext(content: testContent, step: testContent.stepById('a')!, random: Random(4)),
    );

    test('every round has one picture that starts with the sound', () {
      expect(items, hasLength(4));
      for (final item in items.cast<PictureItem>()) {
        final words = [for (final text in item.options) testContent.wordByText(text)!];
        expect(words.where((word) => word.startsWithSound('a')).map((word) => word.text), [
          item.target,
        ]);
        expect(item.options, hasLength(4));
        expect(item.images.keys, unorderedEquals(item.options));
        expect(item.optionNames[item.target]!.clip, 'words/abeja.m4a');
      }
    });
  });

  test('a syllable step asks for each of its syllables once', () {
    Word pictured(String text, List<String> sounds) =>
        Word(text: text, syllables: sounds, sounds: sounds, image: 'words/$text.svg');
    final content = ContentBundle(
      words: [
        pictured('mano', ['ma', 'no']),
        pictured('mesa', ['me', 'sa']),
        pictured('miel', ['miel']),
        pictured('oso', ['o', 'so']),
        pictured('uva', ['u', 'ba']),
        pictured('pato', ['pa', 'to']),
      ],
      stages: const [
        PathStage(
          stage: 4,
          name: 'bosque',
          steps: [
            PathStep(id: 'ma', sounds: ['ma', 'me', 'mi'], activities: ['syllables.starts_with']),
          ],
        ),
      ],
      prompts: testPrompts,
    );

    final items = const StartsWithActivity().buildItems(
      ActivityContext(content: content, step: content.stepById('ma')!, random: Random(1)),
    );

    expect(
      items.map((item) => item.promptId),
      unorderedEquals([
        'syllables.starts_with.ma',
        'syllables.starts_with.me',
        'syllables.starts_with.mi',
      ]),
    );
    for (final item in items) {
      final sound = item.promptId.split('.').last;
      expect(content.wordByText(item.target)!.startsWithSound(sound), isTrue);
      final others = item.options.where((option) => option != item.target);
      expect(others.every((text) => !content.wordByText(text)!.startsWithSound(sound)), isTrue);
    }
  });

  group('game', () {
    late RecordingPromptPlayer player;
    late InMemoryEventLog log;

    Future<void> play(WidgetTester tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      player = RecordingPromptPlayer();
      log = InMemoryEventLog();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contentProvider.overrideWith((ref) async => testContent),
            promptPlayerProvider.overrideWithValue(player),
            eventLogProvider.overrideWithValue(log),
          ],
          child: MaterialApp(
            home: ActivityScreen(
              stepId: 'a',
              activityId: ActivityIds.startsWith,
              celebrationDuration: const Duration(milliseconds: 10),
              random: Random(2),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('start')));
      await tester.pumpAndSettle();
    }

    testWidgets('picking the picture that starts with the sound completes the step', (
      tester,
    ) async {
      await play(tester);
      expect(player.spoken.last, 'starts a');
      expect(find.byKey(DemoOverlay.handKey), findsOneWidget);

      for (var round = 0; round < 4; round++) {
        await tester.tap(find.byKey(const ValueKey('choice-abeja')));
        await tester.pump();
        expect(player.spoken.last, 'abeja correct');
        await tester.pumpAndSettle(const Duration(milliseconds: 20));
      }

      expect(find.byKey(const ValueKey('reward')), findsOneWidget);
      final container = ProviderScope.containerOf(tester.element(find.byType(ActivityScreen)));
      expect(container.read(completedStepsProvider), contains('a'));
    });

    testWidgets('Leo names a wrong picture before asking again', (tester) async {
      await play(tester);
      final word = [
        'oso',
        'uva',
        'mesa',
      ].firstWhere((word) => tester.any(find.byKey(ValueKey('choice-$word'))));

      await tester.tap(find.byKey(ValueKey('choice-$word')));
      await tester.pump();

      expect(player.spoken.last, '$word retry starts a');
      expect(player.utterances.last.lines.first.clip, 'words/$word.m4a');
    });
  });
}
