import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logging/logging_providers.dart';
import 'in_memory_progress_store.dart';
import 'mastery.dart';
import 'progress_store.dart';

final progressStoreProvider = Provider<ProgressStore>((ref) => InMemoryProgressStore());

final masteredStepsProvider = Provider<Set<String>>(
  (ref) => Mastery.masteredSteps(ref.watch(eventLogProvider).events),
);

final completedStepsProvider = NotifierProvider<CompletedSteps, Set<String>>(CompletedSteps.new);

class CompletedSteps extends Notifier<Set<String>> {
  @override
  Set<String> build() => ref.read(progressStoreProvider).completedSteps;

  Future<void> markCompleted(String stepId) async {
    if (state.contains(stepId)) return;
    state = {...state, stepId};
    await ref.read(progressStoreProvider).markCompleted(stepId);
  }
}
