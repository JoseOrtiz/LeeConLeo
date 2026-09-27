import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/utils/hex_color.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class StageTintsRule implements ValidationRule {
  const StageTintsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final stage in bundle.stages) {
      final tint = stage.tint;
      if (tint != null && parseHexColor(tint) == null) {
        yield ValidationIssue.error('stage ${stage.stage}: tint "$tint" is not a #RRGGBB color');
      }
    }
  }
}
