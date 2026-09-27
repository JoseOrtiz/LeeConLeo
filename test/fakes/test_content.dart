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
  'spatial.up_down.intro': ['intro'],
  'spatial.up_down.up': ['say up'],
  'spatial.up_down.down': ['say down'],
});

const testContent = ContentBundle(
  words: [
    Word(text: 'mano', syllables: ['ma', 'no'], sounds: ['ma', 'no']),
  ],
  stages: [
    PathStage(
      stage: 0,
      name: 'Leo explora',
      steps: [
        PathStep(id: 'up-down', activities: ['spatial.up_down']),
        PathStep(id: 'a', grapheme: 'a', sound: 'a', activities: ['letter.meet']),
      ],
    ),
  ],
  prompts: testPrompts,
);
