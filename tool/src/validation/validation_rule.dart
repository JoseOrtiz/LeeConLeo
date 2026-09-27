import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import 'validation_issue.dart';

abstract interface class ValidationRule {
  Iterable<ValidationIssue> check(ContentBundle bundle);
}
