import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logging/logging_providers.dart';
import '../profiles/profile_providers.dart';
import 'in_memory_progress_store.dart';
import 'mastery.dart';
import 'progress_store.dart';

final progressStoreProvider = Provider<ProgressStore>(
  (ref) => ref.watch(activeProfileProvider)?.data.progress ?? InMemoryProgressStore(),
);

final masteredStepsProvider = Provider<Set<String>>(
  (ref) => Mastery.masteredSteps(ref.watch(eventLogProvider).events),
);

final playedGamesProvider = NotifierProvider<PlayedGames, Set<PlayedGame>>(PlayedGames.new);

class PlayedGames extends Notifier<Set<PlayedGame>> {
  @override
  Set<PlayedGame> build() => ref.watch(progressStoreProvider).playedGames;

  Future<void> markPlayed(PlayedGame game) async {
    if (state.contains(game)) return;
    state = {...state, game};
    await ref.read(progressStoreProvider).markPlayed(game);
  }
}

final completedStepsProvider = NotifierProvider<CompletedSteps, Set<String>>(CompletedSteps.new);

class CompletedSteps extends Notifier<Set<String>> {
  @override
  Set<String> build() => ref.watch(progressStoreProvider).completedSteps;

  Future<void> markCompleted(String stepId) async {
    if (state.contains(stepId)) return;
    state = {...state, stepId};
    await ref.read(progressStoreProvider).markCompleted(stepId);
  }
}
