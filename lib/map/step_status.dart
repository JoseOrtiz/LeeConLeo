import '../core/content/models/path_step.dart';

enum StepStatus { done, next, locked }

Map<String, StepStatus> stepStatuses(
  Iterable<PathStep> steps, {
  required Set<String> completed,
  required bool Function(PathStep step) isPlayable,
}) {
  var nextFound = false;
  final statuses = <String, StepStatus>{};
  for (final step in steps) {
    if (completed.contains(step.id)) {
      statuses[step.id] = StepStatus.done;
    } else if (!nextFound && isPlayable(step)) {
      nextFound = true;
      statuses[step.id] = StepStatus.next;
    } else {
      statuses[step.id] = StepStatus.locked;
    }
  }
  return statuses;
}
