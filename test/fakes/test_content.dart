import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

const testPrompts = PromptLibrary({
  'feedback.correct': ['correct'],
  'feedback.retry': ['retry'],
  'feedback.hint': ['hint'],
  'reward': ['reward'],
  'home.intro': ['home intro'],
  'home.locked': ['home locked'],
  'spatial.up_down.intro': ['intro'],
  'spatial.up_down.up': ['say up'],
  'spatial.up_down.down': ['say down'],
  'spatial.left_right.intro': ['intro'],
  'spatial.left_right.left': ['say left'],
  'spatial.left_right.right': ['say right'],
  'spatial.positions.intro': ['intro'],
  'spatial.positions.over': ['say over'],
  'spatial.positions.under': ['say under'],
  'spatial.positions.between': ['say between'],
});

const testTint = '#EEF7E4';

const testContent = ContentBundle(
  words: [
    Word(text: 'mano', syllables: ['ma', 'no'], sounds: ['ma', 'no']),
  ],
  stages: [
    PathStage(
      stage: 0,
      name: 'Leo explora',
      scene: 'scenes/meadow.svg',
      tint: testTint,
      steps: [
        PathStep(id: 'up-down', activities: ['spatial.up_down']),
        PathStep(id: 'left-right', activities: ['spatial.left_right']),
        PathStep(id: 'positions', activities: ['spatial.positions']),
        PathStep(id: 'a', grapheme: 'a', sound: 'a', activities: ['letter.meet']),
      ],
    ),
  ],
  prompts: testPrompts,
);
