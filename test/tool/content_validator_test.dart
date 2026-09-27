import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

import '../../tool/src/validation/rules/known_activities_rule.dart';
import '../../tool/src/validation/rules/path_images_rule.dart';
import '../../tool/src/validation/rules/stage_tints_rule.dart';
import '../../tool/src/validation/rules/syllables_match_text_rule.dart';
import '../../tool/src/validation/rules/unique_ids_rule.dart';

ContentBundle _bundle({List<Word> words = const [], List<PathStep> steps = const []}) =>
    ContentBundle(
      words: words,
      stages: [PathStage(stage: 0, name: 'test', steps: steps)],
      prompts: const PromptLibrary({}),
    );

void main() {
  test('flags syllables that do not spell the word', () {
    final bundle = _bundle(
      words: [
        const Word(text: 'mano', syllables: ['ma', 'mo'], sounds: ['ma', 'mo']),
      ],
    );
    expect(const SyllablesMatchTextRule().check(bundle).single.isError, isTrue);
  });

  test('flags duplicate words and steps', () {
    const word = Word(text: 'sol', syllables: ['sol'], sounds: ['sol']);
    const step = PathStep(id: 'a', activities: []);
    final bundle = _bundle(words: [word, word], steps: [step, step]);
    expect(const UniqueIdsRule().check(bundle), hasLength(2));
  });

  test('flags unknown activity ids', () {
    final bundle = _bundle(
      steps: [
        const PathStep(id: 'a', activities: ['letter.meet', 'letter.dance']),
      ],
    );
    final issues = const KnownActivitiesRule().check(bundle).toList();
    expect(issues.single.message, contains('letter.dance'));
  });

  test('flags step icons that do not exist', () {
    final bundle = _bundle(
      steps: [
        const PathStep(id: 'up-down', activities: [], icon: 'steps/up_down.svg'),
        const PathStep(id: 'lost', activities: [], icon: 'steps/missing.svg'),
        const PathStep(id: 'a', activities: []),
      ],
    );
    final issues = const PathImagesRule().check(bundle).toList();
    expect(issues.single.message, contains('lost'));
  });

  test('flags stage scenes that do not exist', () {
    const bundle = ContentBundle(
      words: [],
      stages: [
        PathStage(stage: 0, name: 'ok', scene: 'scenes/meadow.svg', steps: []),
        PathStage(stage: 1, name: 'lost', scene: 'scenes/missing.svg', steps: []),
      ],
      prompts: PromptLibrary({}),
    );
    final issues = const PathImagesRule().check(bundle).toList();
    expect(issues.single.message, contains('stage 1'));
  });

  test('flags stage tints that are not colors', () {
    const bundle = ContentBundle(
      words: [],
      stages: [
        PathStage(stage: 0, name: 'ok', tint: '#EEF7E4', steps: []),
        PathStage(stage: 1, name: 'bad', tint: 'green', steps: []),
      ],
      prompts: PromptLibrary({}),
    );
    final issues = const StageTintsRule().check(bundle).toList();
    expect(issues.single.message, contains('green'));
  });
}
