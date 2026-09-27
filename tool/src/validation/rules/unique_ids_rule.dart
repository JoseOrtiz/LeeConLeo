import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class UniqueIdsRule implements ValidationRule {
  const UniqueIdsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final text in _duplicates(bundle.words.map((word) => word.text))) {
      yield ValidationIssue.error('word "$text" is defined more than once');
    }
    for (final id in _duplicates(bundle.steps.map((step) => step.id))) {
      yield ValidationIssue.error('step "$id" is defined more than once');
    }
  }

  Set<String> _duplicates(Iterable<String> values) {
    final seen = <String>{};
    return {
      for (final value in values)
        if (!seen.add(value)) value,
    };
  }
}
