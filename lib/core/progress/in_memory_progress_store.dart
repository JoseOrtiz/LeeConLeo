import 'progress_store.dart';

class InMemoryProgressStore implements ProgressStore {
  InMemoryProgressStore([Set<String> completed = const {}]) : _completed = {...completed};

  final Set<String> _completed;

  @override
  Set<String> get completedSteps => Set.unmodifiable(_completed);

  @override
  Future<void> markCompleted(String stepId) async => _completed.add(stepId);
}
