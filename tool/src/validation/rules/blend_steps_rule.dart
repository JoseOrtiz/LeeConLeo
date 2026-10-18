import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/buildable_words.dart';
import 'package:lee_con_leo/core/content/listening_prompt_ids.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/syllable_prompt_ids.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class BlendStepsRule implements ValidationRule {
  const BlendStepsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    final steps = bundle.steps.where((step) => step.activities.contains(ActivityIds.blend));
    if (steps.isEmpty) return;
    if (!bundle.prompts.contains(SyllablePromptIds.blendAsk)) {
      yield ValidationIssue.error('missing prompt "${SyllablePromptIds.blendAsk}"');
    }
    for (final step in steps) {
      final words = BuildableWords.of(bundle, step);
      if (words.isEmpty) {
        yield ValidationIssue.error(
          'step "${step.id}": no word with a picture is made only of syllables known by then',
        );
      }
      for (final word in words) {
        final prompt = ListeningPromptIds.clapSplit(word.text);
        if (!bundle.prompts.contains(prompt)) {
          yield ValidationIssue.error('step "${step.id}": missing prompt "$prompt"');
        }
      }
    }
  }
}
