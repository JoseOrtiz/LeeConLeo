typedef PlayedGame = ({String stepId, String activityId});

abstract interface class ProgressStore {
  Set<String> get completedSteps;

  Set<PlayedGame> get playedGames;

  Future<void> markCompleted(String stepId);

  Future<void> markPlayed(PlayedGame game);
}
