import 'dart:io';

import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/sound_clips.dart';
import 'package:lee_con_leo/core/content/syllable_prompt_ids.dart';

import '../../content_paths.dart';
import '../validation_issue.dart';
import '../validation_rule.dart';

class SyllableStepsRule implements ValidationRule {
  const SyllableStepsRule({this.checkClips = true});

  final bool checkClips;

  static const syllableActivities = {
    ActivityIds.syllableMeet,
    ActivityIds.syllableTrace,
    ActivityIds.syllableFind,
  };

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    for (final step in bundle.steps) {
      final activities = step.activities.where(syllableActivities.contains).toList();
      if (activities.isEmpty) continue;
      if (step.sounds.length < 2) {
        yield ValidationIssue.error(
          'step "${step.id}": syllable activities need two or more sounds',
        );
        continue;
      }
      for (final sound in step.sounds) {
        for (final activity in activities) {
          for (final id in SyllablePromptIds.requiredFor(activity, sound)) {
            if (!bundle.prompts.contains(id)) {
              yield ValidationIssue.error('step "${step.id}": missing prompt "$id"');
            }
          }
        }
        if (activities.contains(ActivityIds.syllableTrace)) {
          final strokes = bundle.syllables[sound];
          if (strokes == null || strokes.isEmpty || strokes.any((stroke) => stroke.isEmpty)) {
            yield ValidationIssue.error('step "${step.id}": no stroke data for "$sound"');
          }
        }
        final clip = '${ContentPaths.audio}/${SoundClips.of(sound)}';
        if (checkClips &&
            activities.contains(ActivityIds.syllableMeet) &&
            !File(clip).existsSync()) {
          yield ValidationIssue.error('step "${step.id}": clip "$clip" not found');
        }
      }
    }
  }
}
