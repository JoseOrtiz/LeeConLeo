import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/sound_prompt_ids.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class StartsWithStepsRule implements ValidationRule {
  const StartsWithStepsRule({this.distractors = 3});

  final int distractors;

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    final steps = bundle.steps.where((step) => step.activities.contains(ActivityIds.startsWith));
    if (steps.isEmpty) return;
    final pictured = bundle.words.where((word) => word.image != null).toList();
    for (final word in pictured.where((word) => word.audio == null)) {
      yield ValidationIssue.error('"${word.text}": a word with a picture needs audio');
    }
    for (final step in steps) {
      final sound = step.sound;
      if (sound == null) {
        yield ValidationIssue.error('step "${step.id}": ${ActivityIds.startsWith} needs a sound');
        continue;
      }
      final prompt = SoundPromptIds.startsWith(sound);
      if (!bundle.prompts.contains(prompt)) {
        yield ValidationIssue.error('step "${step.id}": missing prompt "$prompt"');
      }
      final matches = pictured.where((word) => word.startsWithSound(sound)).length;
      if (matches == 0) {
        yield ValidationIssue.error(
          'step "${step.id}": no word with a picture starts with "$sound"',
        );
      }
      if (pictured.length - matches < distractors) {
        yield ValidationIssue.error(
          'step "${step.id}": fewer than $distractors pictures that do not start with "$sound"',
        );
      }
    }
  }
}
