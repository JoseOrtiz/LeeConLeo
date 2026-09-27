import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class SyllablesMatchTextRule implements ValidationRule {
  const SyllablesMatchTextRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final word in bundle.words) {
      if (word.syllables.join() != word.text.replaceAll(' ', '')) {
        yield ValidationIssue.error(
          '"${word.text}": syllables ${word.syllables} do not spell the word',
        );
      }
      if (word.sounds.length != word.syllables.length) {
        yield ValidationIssue.error('"${word.text}": needs one sound per syllable');
      }
    }
  }
}
