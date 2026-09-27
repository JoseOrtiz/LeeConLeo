import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class KnownActivitiesRule implements ValidationRule {
  const KnownActivitiesRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final step in bundle.steps) {
      for (final activity in step.activities) {
        if (!ActivityIds.all.contains(activity)) {
          yield ValidationIssue.error('step "${step.id}": unknown activity "$activity"');
        }
      }
    }
  }
}
