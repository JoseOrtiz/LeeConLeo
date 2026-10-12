import '../progress/progress_store.dart';
import 'app_database.dart';

class DriftProgressStore implements ProgressStore {
  DriftProgressStore._(this._database, this._profileId, this._completed, this._played);

  static Future<DriftProgressStore> open(AppDatabase database, int profileId) async {
    final completed = await (database.select(
      database.completedSteps,
    )..where((row) => row.profileId.equals(profileId))).get();
    final played = await (database.select(
      database.playedGames,
    )..where((row) => row.profileId.equals(profileId))).get();
    return DriftProgressStore._(
      database,
      profileId,
      {for (final row in completed) row.stepId},
      {for (final row in played) (stepId: row.stepId, activityId: row.activityId)},
    );
  }

  final AppDatabase _database;
  final int _profileId;
  final Set<String> _completed;
  final Set<PlayedGame> _played;

  @override
  Set<String> get completedSteps => Set.unmodifiable(_completed);

  @override
  Set<PlayedGame> get playedGames => Set.unmodifiable(_played);

  @override
  Future<void> markCompleted(String stepId) async {
    if (!_completed.add(stepId)) return;
    await _database
        .into(_database.completedSteps)
        .insertOnConflictUpdate(
          CompletedStepsCompanion.insert(
            profileId: _profileId,
            stepId: stepId,
            completedAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> markPlayed(PlayedGame game) async {
    if (!_played.add(game)) return;
    await _database
        .into(_database.playedGames)
        .insertOnConflictUpdate(
          PlayedGamesCompanion.insert(
            profileId: _profileId,
            stepId: game.stepId,
            activityId: game.activityId,
            playedAt: DateTime.now(),
          ),
        );
  }
}
