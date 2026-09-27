import 'dart:io';

import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

import '../../content_paths.dart';
import '../validation_issue.dart';
import '../validation_rule.dart';

class WordAssetsRule implements ValidationRule {
  const WordAssetsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    yield* _checkKind(bundle.words, 'image', (word) => word.image, ContentPaths.images);
    yield* _checkKind(bundle.words, 'audio', (word) => word.audio, ContentPaths.audio);
  }

  Iterable<ValidationIssue> _checkKind(
    List<Word> words,
    String kind,
    String? Function(Word word) fileOf,
    String root,
  ) sync* {
    var missing = 0;
    for (final word in words) {
      final file = fileOf(word);
      if (file == null) {
        missing++;
      } else if (!File('$root/$file').existsSync()) {
        yield ValidationIssue.error('"${word.text}": $kind file "$root/$file" not found');
      }
    }
    if (missing > 0) {
      yield ValidationIssue.warning('$missing of ${words.length} words have no $kind yet');
    }
  }
}
