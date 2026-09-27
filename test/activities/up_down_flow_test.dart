import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_screen.dart';
import 'package:lee_con_leo/core/audio/audio_providers.dart';
import 'package:lee_con_leo/core/content/content_providers.dart';
import 'package:lee_con_leo/core/logging/in_memory_event_log.dart';
import 'package:lee_con_leo/core/logging/logging_providers.dart';

import '../fakes/recording_prompt_player.dart';
import '../fakes/test_content.dart';

void main() {
  late RecordingPromptPlayer player;
  late InMemoryEventLog log;

  Future<void> pumpActivity(WidgetTester tester) async {
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
            stepId: 'up-down',
            activityId: 'spatial.up_down',
            celebrationDuration: const Duration(milliseconds: 10),
            random: Random(1),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  String targetOf(String prompt) => prompt == 'say up' ? 'up' : 'down';

  testWidgets('a child can play all items and reach the reward', (tester) async {
    await pumpActivity(tester);
    expect(player.spoken.single, 'intro');

    await tester.tap(find.byKey(const ValueKey('start')));
    await tester.pumpAndSettle();

    for (var i = 0; i < 6; i++) {
      final target = targetOf(player.spoken.last);
      await tester.tap(find.byKey(ValueKey('choice-$target')));
      await tester.pump();
      expect(find.byKey(const ValueKey('celebration')), findsOneWidget);
      await tester.pumpAndSettle(const Duration(milliseconds: 20));
    }

    expect(find.byKey(const ValueKey('reward')), findsOneWidget);
    expect(log.events, hasLength(6));
    expect(log.events.every((event) => event.isCorrect), isTrue);
  });

  testWidgets('the repeat button speaks the current prompt again', (tester) async {
    await pumpActivity(tester);
    await tester.tap(find.byKey(const ValueKey('start')));
    await tester.pumpAndSettle();
    final prompt = player.spoken.last;

    await tester.tap(find.byKey(const ValueKey('repeat')));
    expect(player.spoken.last, prompt);
    expect(player.spoken.where((text) => text == prompt).length, greaterThanOrEqualTo(2));
  });
}
