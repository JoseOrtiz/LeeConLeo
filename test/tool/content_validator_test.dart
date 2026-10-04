import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/letter_shape.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

import '../../tool/src/validation/rules/known_activities_rule.dart';
import '../../tool/src/validation/rules/letter_steps_rule.dart';
import '../../tool/src/validation/rules/path_images_rule.dart';
import '../../tool/src/validation/rules/prompt_clips_rule.dart';
import '../../tool/src/validation/rules/stage_tints_rule.dart';
import '../../tool/src/validation/rules/starts_with_steps_rule.dart';
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

  test('flags clips without a prompt and phrases without a clip', () {
    const bundle = ContentBundle(
      words: [],
      stages: [],
      prompts: PromptLibrary(
        {
          'feedback.correct': ['¡Muy bien!', '¡Súper!'],
        },
        clips: {
          'feedback.correct.0': 'prompts/feedback.correct.0.m4a',
          'feedback.correct.5': 'prompts/feedback.correct.5.m4a',
        },
      ),
    );
    final issues = const PromptClipsRule().check(bundle).toList();

    expect(issues.every((issue) => issue.isError), isTrue);
    expect(issues.map((issue) => issue.message), [
      contains('feedback.correct.5'),
      contains('"feedback.correct.1" has no recorded clip'),
    ]);
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

  group('letter steps', () {
    ContentBundle letterBundle({
      String? word = 'abeja',
      Map<String, LetterShape> letters = const {},
      Map<String, List<String>> prompts = const {},
    }) => ContentBundle(
      words: const [
        Word(
          text: 'abeja',
          syllables: ['a', 'be', 'ja'],
          sounds: ['a', 'be', 'ja'],
          image: 'x.svg',
        ),
        Word(text: 'ala', syllables: ['a', 'la'], sounds: ['a', 'la']),
      ],
      stages: [
        PathStage(
          stage: 2,
          name: 'vocales',
          steps: [
            PathStep(
              id: 'a',
              grapheme: 'a',
              word: word,
              activities: const ['letter.meet', 'letter.trace', 'letter.find'],
            ),
          ],
        ),
      ],
      prompts: PromptLibrary(prompts),
      letters: letters,
    );

    const shape = LetterShape(
      lower: [
        [Point(0.0, 0.0), Point(0.0, 10.0)],
      ],
      upper: [
        [Point(0.0, 0.0), Point(5.0, 10.0)],
      ],
    );
    const prompts = {
      'letter.meet.a': ['Esta es la a.'],
      'letter.meet.a.upper': ['Toca la a mayúscula.'],
      'letter.meet.a.lower': ['Toca la a minúscula.'],
      'letter.trace.a.lower': ['Repasa la a minúscula.'],
      'letter.trace.a.upper': ['Repasa la a mayúscula.'],
      'letter.find.a': ['Revienta las a.'],
    };

    test('a complete letter step passes', () {
      final bundle = letterBundle(letters: const {'a': shape}, prompts: prompts);
      expect(const LetterStepsRule().check(bundle), isEmpty);
    });

    test('flags missing prompts and stroke data', () {
      final issues = const LetterStepsRule().check(letterBundle()).map((i) => i.message).toList();

      expect(issues, hasLength(7));
      expect(issues, contains(contains('"letter.find.a"')));
      expect(issues, contains(contains('no stroke data for "a"')));
    });

    test('flags a meet word that is missing or has no picture', () {
      final noPicture = letterBundle(word: 'ala', letters: const {'a': shape}, prompts: prompts);
      final unknown = letterBundle(word: 'oso', letters: const {'a': shape}, prompts: prompts);

      expect(const LetterStepsRule().check(noPicture).single.message, contains('no image'));
      expect(
        const LetterStepsRule().check(unknown).single.message,
        contains('not in the word bank'),
      );
    });
  });

  group('starts with steps', () {
    Word pictured(String text, List<String> sounds, {bool hasAudio = true}) => Word(
      text: text,
      syllables: sounds,
      sounds: sounds,
      image: 'words/$text.svg',
      audio: hasAudio ? 'words/$text.m4a' : null,
    );

    ContentBundle bundle(List<Word> words, {String? sound = 'a', bool hasPrompt = true}) =>
        ContentBundle(
          words: words,
          stages: [
            PathStage(
              stage: 2,
              name: 'vocales',
              steps: [
                PathStep(id: 'a', sound: sound, activities: const ['syllables.starts_with']),
              ],
            ),
          ],
          prompts: PromptLibrary({
            if (hasPrompt) 'syllables.starts_with.a': ['¿Qué dibujo empieza con... a?'],
          }),
        );

    final complete = [
      pictured('abeja', ['a', 'be', 'ja']),
      pictured('oso', ['o', 'so']),
      pictured('uva', ['u', 'ba']),
      pictured('mesa', ['me', 'sa']),
    ];

    test('a step with a sound, its phrase and enough pictures passes', () {
      expect(const StartsWithStepsRule().check(bundle(complete)), isEmpty);
    });

    test('flags a missing phrase, too few pictures and pictures without audio', () {
      final issues = const StartsWithStepsRule()
          .check(
            bundle([
              pictured('abeja', ['a', 'be', 'ja']),
              pictured('oso', ['o', 'so'], hasAudio: false),
            ], hasPrompt: false),
          )
          .map((issue) => issue.message)
          .toList();

      expect(issues, [
        contains('"oso": a word with a picture needs audio'),
        contains('missing prompt "syllables.starts_with.a"'),
        contains('fewer than 3 pictures'),
      ]);
    });

    test('flags a step without a sound or without a matching picture', () {
      expect(
        const StartsWithStepsRule().check(bundle(complete, sound: null)).single.message,
        contains('needs a sound'),
      );
      expect(
        const StartsWithStepsRule().check(bundle(complete.skip(1).toList())).single.message,
        contains('no word with a picture starts with "a"'),
      );
    });
  });
}
