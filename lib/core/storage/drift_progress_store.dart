import '../progress/progress_store.dart';
import 'app_database.dart';

class DriftProgressStore implements ProgressStore {
  DriftProgressStore._(this._database, this._profileId, this._completed);

  static Future<DriftProgressStore> open(AppDatabase database, int profileId) async {
    final rows = await (database.select(
      database.completedSteps,
    )..where((row) => row.profileId.equals(profileId))).get();
    return DriftProgressStore._(database, profileId, {for (final row in rows) row.stepId});
  }

  final AppDatabase _database;
  final int _profileId;
  final Set<String> _completed;

  @override
  Set<String> get completedSteps => Set.unmodifiable(_completed);

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
}
