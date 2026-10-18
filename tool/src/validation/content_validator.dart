import 'package:lee_con_leo/core/content/models/content_bundle.dart';

import 'rules/activity_intros_rule.dart';
import 'rules/blend_steps_rule.dart';
import 'rules/build_word_steps_rule.dart';
import 'rules/clap_steps_rule.dart';
import 'rules/known_activities_rule.dart';
import 'rules/letter_steps_rule.dart';
import 'rules/path_images_rule.dart';
import 'rules/picture_sound_steps_rule.dart';
import 'rules/place_size_rule.dart';
import 'rules/prompt_clips_rule.dart';
import 'rules/stage_tints_rule.dart';
import 'rules/step_has_words_rule.dart';
import 'rules/syllable_steps_rule.dart';
import 'rules/syllables_match_text_rule.dart';
import 'rules/unique_ids_rule.dart';
import 'rules/word_assets_rule.dart';
import 'validation_issue.dart';
import 'validation_rule.dart';

class ContentValidator {
  const ContentValidator({this.rules = defaultRules});

  static const defaultRules = <ValidationRule>[
    SyllablesMatchTextRule(),
    UniqueIdsRule(),
    KnownActivitiesRule(),
    ActivityIntrosRule(),
    WordAssetsRule(),
    PathImagesRule(),
    StageTintsRule(),
    PromptClipsRule(),
    StepHasWordsRule(),
    PlaceSizeRule(),
    LetterStepsRule(),
    SyllableStepsRule(),
    PictureSoundStepsRule(),
    BuildWordStepsRule(),
    ClapStepsRule(),
    BlendStepsRule(),
  ];

  final List<ValidationRule> rules;

  List<ValidationIssue> validate(ContentBundle bundle) => [
    for (final rule in rules) ...rule.check(bundle),
  ];
}
