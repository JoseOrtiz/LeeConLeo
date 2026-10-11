import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/buildable_words.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/syllable_prompt_ids.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class BuildWordStepsRule implements ValidationRule {
  const BuildWordStepsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final step in bundle.steps) {
      if (!step.activities.contains(ActivityIds.buildWord)) continue;
      if (step.sounds.length < 2) {
        yield ValidationIssue.error(
          'step "${step.id}": ${ActivityIds.buildWord} needs two or more sounds',
        );
        continue;
      }
      final words = BuildableWords.of(bundle, step);
      if (words.isEmpty) {
        yield ValidationIssue.error(
          'step "${step.id}": no word with a picture is made only of syllables known by then',
        );
      }
      for (final word in words) {
        final prompt = SyllablePromptIds.buildWord(word.text);
        if (!bundle.prompts.contains(prompt)) {
          yield ValidationIssue.error('step "${step.id}": missing prompt "$prompt"');
        }
        if (word.audio == null) {
          yield ValidationIssue.error('"${word.text}": a word to build needs audio');
        }
      }
    }
  }
}
