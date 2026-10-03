import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/letter_prompt_ids.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/letter_shape.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class LetterStepsRule implements ValidationRule {
  const LetterStepsRule();

  static const letterActivities = {ActivityIds.meet, ActivityIds.trace, ActivityIds.find};

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final step in bundle.steps) {
      final activities = step.activities.where(letterActivities.contains).toList();
      if (activities.isEmpty) continue;
      final grapheme = step.grapheme;
      if (grapheme == null) {
        yield ValidationIssue.error('step "${step.id}": letter activities need a grapheme');
        continue;
      }
      for (final activity in activities) {
        for (final id in LetterPromptIds.requiredFor(activity, grapheme)) {
          if (!bundle.prompts.contains(id)) {
            yield ValidationIssue.error('step "${step.id}": missing prompt "$id"');
          }
        }
      }
      if (activities.contains(ActivityIds.meet)) yield* _checkWord(bundle, step);
      if (activities.contains(ActivityIds.trace)) yield* _checkShape(bundle, step, grapheme);
    }
  }

  Iterable<ValidationIssue> _checkWord(ContentBundle bundle, PathStep step) sync* {
    final text = step.word;
    if (text == null) {
      yield ValidationIssue.error('step "${step.id}": letter.meet needs a word');
      return;
    }
    final word = bundle.wordByText(text);
    if (word == null) {
      yield ValidationIssue.error('step "${step.id}": word "$text" is not in the word bank');
    } else if (word.image == null) {
      yield ValidationIssue.error('step "${step.id}": word "$text" has no image');
    }
  }

  Iterable<ValidationIssue> _checkShape(
    ContentBundle bundle,
    PathStep step,
    String grapheme,
  ) sync* {
    final shape = bundle.letters[grapheme];
    if (shape == null) {
      yield ValidationIssue.error('step "${step.id}": no stroke data for "$grapheme"');
      return;
    }
    for (final letterCase in LetterCase.values) {
      final strokes = shape.strokes(letterCase);
      if (strokes.isEmpty || strokes.any((stroke) => stroke.isEmpty)) {
        yield ValidationIssue.error('letter "$grapheme": ${letterCase.name} strokes are empty');
      }
    }
  }
}
