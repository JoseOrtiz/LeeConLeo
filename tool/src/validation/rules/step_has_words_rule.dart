import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class StepHasWordsRule implements ValidationRule {
  const StepHasWordsRule({this.minimumDistractors = 3});

  final int minimumDistractors;

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final step in bundle.steps) {
      final sound = step.sound;
      if (sound == null) continue;
      final matches = bundle.words.where((word) => word.startsWithSound(sound)).length;
      final distractors = bundle.words.length - matches;
      if (matches == 0) {
        yield ValidationIssue.warning('step "${step.id}": no word starts with the sound "$sound"');
      }
      if (distractors < minimumDistractors) {
        yield ValidationIssue.warning(
          'step "${step.id}": fewer than $minimumDistractors distractors',
        );
      }
    }
  }
}
