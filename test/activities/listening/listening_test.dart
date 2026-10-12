import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_context.dart';
import 'package:lee_con_leo/activities/common/activity_screen.dart';
import 'package:lee_con_leo/activities/listening/clap_activity.dart';
import 'package:lee_con_leo/activities/listening/clap_view.dart';
import 'package:lee_con_leo/activities/sounds/picture_sound_activity.dart';
import 'package:lee_con_leo/activities/sounds/picture_sound_view.dart';
import 'package:lee_con_leo/core/audio/audio_providers.dart';
import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/content_providers.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';
import 'package:lee_con_leo/core/content/models/word.dart';
import 'package:lee_con_leo/core/logging/in_memory_event_log.dart';
import 'package:lee_con_leo/core/logging/logging_providers.dart';

import '../../fakes/recording_prompt_player.dart';
import '../../fakes/test_content.dart';

Word _word(String text, List<String> syllables) => Word(
  text: text,
  syllables: syllables,
  sounds: syllables,
  image: 'words/oso.svg',
  audio: 'words/$text.m4a',
);

final _words = [
  _word('oso', ['o', 'so']),
  _word('ola', ['o', 'la']),
  _word('ojota', ['o', 'jo', 'ta']),
  _word('oveja', ['o', 've', 'ja']),
  _word('sol', ['sol']),
  _word('mariposa', ['ma', 'ri', 'po', 'sa']),
  _word('abeja', ['a', 'be', 'ja']),
  _word('uva', ['u', 'ba']),
];

final _content = ContentBundle(
  words: _words,
  stages: const [
    PathStage(
      stage: 2,
      name: 'vocales',
      steps: [
        PathStep(
          id: 'o',
          grapheme: 'o',
          sounds: ['o'],
          activities: [ActivityIds.clap, ActivityIds.sameSound],
        ),
      ],
    ),
  ],
  prompts: PromptLibrary({
    ...testPrompts.phrases,
    'listening.clap.intro': ['intro'],
    'listening.clap.ask': ['clap'],
    'listening.same_sound.intro': ['intro'],
    'syllables.starts_with.o': ['starts o'],
    for (final word in _words) 'listening.clap.${word.text}': [word.syllables.join('-')],
  }),
);

void main() {
  final step = _content.stepById('o')!;

  test('clap rounds use the step words first and vary the number of syllables', () {
    final items = const ClapActivity()
        .buildItems(ActivityContext(content: _content, step: step, random: Random(3)))
        .cast<ClapItem>();

    expect(items, hasLength(4));
    final words = [for (final item in items) item.promptTail!.text];
    expect(words.every((word) => word.startsWith('o')), isTrue);
    expect(items.map((item) => item.claps).toSet(), {2, 3});
    for (final item in items) {
      final word = _words.firstWhere((word) => word.text == item.promptTail!.text);
      expect(item.claps, word.syllables.length);
      expect(item.promptTail!.clip, word.audio);
      expect(item.optionNames[item.target]!.text, word.syllables.join('-'));
    }
  });

  group('game', () {
    late RecordingPromptPlayer player;
    late InMemoryEventLog log;

    Future<void> play(WidgetTester tester, String activityId) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      player = RecordingPromptPlayer();
      log = InMemoryEventLog();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contentProvider.overrideWith((ref) async => _content),
            promptPlayerProvider.overrideWithValue(player),
            eventLogProvider.overrideWithValue(log),
          ],
          child: MaterialApp(
            home: ActivityScreen(
              stepId: 'o',
              activityId: activityId,
              celebrationDuration: const Duration(milliseconds: 10),
              random: Random(4),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('start')));
      await tester.pumpAndSettle();
    }

    String askedWord() => player.utterances.last.lines.last.text;

    Future<void> clap(WidgetTester tester, int times) async {
      for (var i = 0; i < times; i++) {
        await tester.tap(find.byKey(ClapView.clapKey));
        await tester.pump();
      }
      await tester.tap(find.byKey(ClapView.doneKey));
      await tester.pump();
    }

    int syllablesOf(String text) => _words.firstWhere((word) => word.text == text).syllables.length;

    testWidgets('clapping once per syllable says the word split up and moves on', (tester) async {
      await play(tester, ActivityIds.clap);

      for (var round = 0; round < 4; round++) {
        final word = askedWord();
        expect(player.spoken.last, 'clap $word');
        await clap(tester, syllablesOf(word));
        expect(
          player.utterances.last.lines.first.text,
          _words.firstWhere((other) => other.text == word).syllables.join('-'),
        );
        expect(player.spoken.last, endsWith('correct'));
        await tester.pumpAndSettle(const Duration(milliseconds: 20));
      }

      expect(find.byKey(const ValueKey('reward')), findsOneWidget);
      expect(log.events.every((event) => event.isCorrect), isTrue);
    });

    testWidgets('a wrong count clears the claps, asks again, and later hints the dots', (
      tester,
    ) async {
      await play(tester, ActivityIds.clap);
      final word = askedWord();
      final claps = syllablesOf(word);

      await clap(tester, claps + 1);
      expect(find.byKey(const ValueKey('clap-dot-0')), findsNothing);
      expect(player.spoken.last, 'retry clap $word');

      await clap(tester, claps + 1);
      expect(find.byKey(ValueKey('clap-dot-${claps - 1}')), findsOneWidget);
      expect(find.byKey(ValueKey('clap-dot-$claps')), findsNothing);
    });

    testWidgets('same sound asks like starts with but shows no letters', (tester) async {
      await play(tester, ActivityIds.sameSound);

      expect(player.spoken.last, 'starts o');
      expect(find.byKey(PictureSoundView.soundKey), findsNothing);
      final item = PictureSoundActivity.sameSound
          .buildItems(ActivityContext(content: _content, step: step, random: Random(1)))
          .first;
      expect(item.options, hasLength(PictureSoundActivity.choices));
    });
  });
}
