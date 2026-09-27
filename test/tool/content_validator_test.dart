import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

import '../../tool/src/validation/rules/known_activities_rule.dart';
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
}
