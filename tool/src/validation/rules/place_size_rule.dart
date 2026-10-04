import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class PlaceSizeRule implements ValidationRule {
  const PlaceSizeRule({this.maxSteps = 6});

  final int maxSteps;

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final place in bundle.stages) {
      if (place.steps.isEmpty) {
        yield ValidationIssue.error('place "${place.name}" has no steps');
      } else if (place.steps.length > maxSteps) {
        yield ValidationIssue.error(
          'place "${place.name}" has ${place.steps.length} steps; split it so each place has '
          'at most $maxSteps and fits one screen',
        );
      }
    }
  }
}
