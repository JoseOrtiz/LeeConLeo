import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/map/step_status.dart';

void main() {
  const steps = [
    PathStep(id: 'up-down', activities: ['spatial.up_down']),
    PathStep(id: 'left-right', activities: ['spatial.left_right']),
    PathStep(id: 'a', activities: ['letter.meet']),
    PathStep(id: 'positions', activities: ['spatial.positions']),
  ];
  bool isPlayable(PathStep step) => step.id != 'a';

  test('the first playable step is next and the rest are locked', () {
    expect(stepStatuses(steps, completed: {}, isPlayable: isPlayable), {
      'up-down': StepStatus.next,
      'left-right': StepStatus.locked,
      'a': StepStatus.locked,
      'positions': StepStatus.locked,
    });
  });

  test('finished steps are done and the next one moves forward', () {
    final statuses = stepStatuses(steps, completed: {'up-down'}, isPlayable: isPlayable);
    expect(statuses['up-down'], StepStatus.done);
    expect(statuses['left-right'], StepStatus.next);
  });

  test('a step with no game yet is skipped when choosing the next one', () {
    final statuses = stepStatuses(
      steps,
      completed: {'up-down', 'left-right'},
      isPlayable: isPlayable,
    );
    expect(statuses['a'], StepStatus.locked);
    expect(statuses['positions'], StepStatus.next);
  });

  test('when everything is done there is no next step', () {
    final statuses = stepStatuses(
      steps,
      completed: {for (final step in steps) step.id},
      isPlayable: isPlayable,
    );
    expect(statuses.values, everyElement(StepStatus.done));
  });
}
