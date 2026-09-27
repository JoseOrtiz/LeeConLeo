import 'dart:io';

import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../../content_paths.dart';
import '../validation_issue.dart';
import '../validation_rule.dart';

class PathImagesRule implements ValidationRule {
  const PathImagesRule({this.imagesRoot = ContentPaths.images});

  final String imagesRoot;

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final stage in bundle.stages) {
      yield* _check('stage ${stage.stage}: scene', stage.scene);
      for (final step in stage.steps) {
        yield* _check('step "${step.id}": icon', step.icon);
      }
    }
  }

  Iterable<ValidationIssue> _check(String owner, String? file) sync* {
    if (file != null && !File('$imagesRoot/$file').existsSync()) {
      yield ValidationIssue.error('$owner file "$imagesRoot/$file" not found');
    }
  }
}
