abstract interface class ProgressStore {
  Set<String> get completedSteps;

  Future<void> markCompleted(String stepId);
}
