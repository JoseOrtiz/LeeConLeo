import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_screen.dart';
import 'package:lee_con_leo/app/app_router.dart';
import 'package:lee_con_leo/app/widgets/pulse.dart';
import 'package:lee_con_leo/core/audio/audio_providers.dart';
import 'package:lee_con_leo/core/content/content_providers.dart';
import 'package:lee_con_leo/core/logging/in_memory_event_log.dart';
import 'package:lee_con_leo/core/logging/logging_providers.dart';
import 'package:lee_con_leo/core/progress/in_memory_progress_store.dart';
import 'package:lee_con_leo/core/progress/progress_providers.dart';

import '../fakes/recording_prompt_player.dart';
import '../fakes/test_content.dart';

void main() {
  late RecordingPromptPlayer player;

  Future<void> pumpHome(WidgetTester tester, {Set<String> completed = const {}}) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
      disableAnimations: true,
    );
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    player = RecordingPromptPlayer();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contentProvider.overrideWith((ref) async => testContent),
          promptPlayerProvider.overrideWithValue(player),
          eventLogProvider.overrideWithValue(InMemoryEventLog()),
          progressStoreProvider.overrideWithValue(InMemoryProgressStore(completed)),
        ],
        child: MaterialApp.router(routerConfig: createAppRouter()),
      ),
    );
    await tester.pumpAndSettle();
  }

  double distanceFromLeoTo(WidgetTester tester, String stepId) =>
      (tester.getCenter(find.byKey(const ValueKey('leo-front'))) -
              tester.getCenter(find.byKey(ValueKey('step-$stepId'))))
          .distance;

  testWidgets('Leo greets the child when the map opens', (tester) async {
    await pumpHome(tester);
    expect(player.spoken, ['home intro']);
  });

  testWidgets('Leo stands beside the next step to play', (tester) async {
    await pumpHome(tester, completed: {'up-down'});
    expect(distanceFromLeoTo(tester, 'left-right'), lessThan(distanceFromLeoTo(tester, 'up-down')));
  });

  testWidgets('a locked step makes Leo explain instead of opening a game', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.byKey(const ValueKey('step-left-right')));
    await tester.pumpAndSettle();

    expect(player.spoken.last, 'home locked');
    expect(find.byType(ActivityScreen), findsNothing);
  });

  testWidgets('the next step opens its game', (tester) async {
    await pumpHome(tester);
    await tester.tap(find.byKey(const ValueKey('step-up-down')));
    await tester.pumpAndSettle();

    expect(find.byType(ActivityScreen), findsOneWidget);
  });

  testWidgets('Leo greets only once, and going back to the map just stops the game', (
    tester,
  ) async {
    await pumpHome(tester);
    await tester.tap(find.byKey(const ValueKey('step-up-down')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('home')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('step-up-down')), findsOneWidget);
    expect(player.spoken.where((text) => text == 'home intro'), hasLength(1));
    expect(player.calls.last, RecordingPromptPlayer.stopCall);
  });

  testWidgets('only the next step pulses', (tester) async {
    await pumpHome(tester, completed: {'up-down'});

    Finder pulsing(String stepId) =>
        find.ancestor(of: find.byKey(ValueKey('step-$stepId')), matching: find.byType(Pulse));
    expect(pulsing('left-right'), findsOneWidget);
    expect(pulsing('up-down'), findsNothing);
    expect(pulsing('positions'), findsNothing);
  });

  testWidgets('a finished step can be played again', (tester) async {
    await pumpHome(tester, completed: {'up-down'});
    await tester.tap(find.byKey(const ValueKey('step-up-down')));
    await tester.pumpAndSettle();

    expect(find.byType(ActivityScreen), findsOneWidget);
  });
}
