import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class ActivityIntrosRule implements ValidationRule {
  const ActivityIntrosRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    final activities = {for (final step in bundle.steps) ...step.activities};
    for (final activity in activities) {
      final intro = '$activity.intro';
      if (!bundle.prompts.contains(intro)) {
        yield ValidationIssue.error('missing prompt "$intro"');
      }
    }
  }
}
