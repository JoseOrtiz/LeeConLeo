import 'progress_store.dart';

class InMemoryProgressStore implements ProgressStore {
  InMemoryProgressStore([Set<String> completed = const {}, Set<PlayedGame> played = const {}])
    : _completed = {...completed},
      _played = {...played};

  final Set<String> _completed;
  final Set<PlayedGame> _played;

  @override
  Set<String> get completedSteps => Set.unmodifiable(_completed);

  @override
  Set<PlayedGame> get playedGames => Set.unmodifiable(_played);

  @override
  Future<void> markCompleted(String stepId) async => _completed.add(stepId);

  @override
  Future<void> markPlayed(PlayedGame game) async => _played.add(game);
}
