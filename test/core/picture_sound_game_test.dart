import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_context.dart';
import 'package:lee_con_leo/activities/sounds/picture_sound_activity.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/path_stage.dart';
import 'package:lee_con_leo/core/content/models/path_step.dart';
import 'package:lee_con_leo/core/content/models/word.dart';
import 'package:lee_con_leo/core/content/picture_sound_game.dart';

import '../fakes/test_content.dart';

Word _word(String text, List<String> syllables, List<String> sounds) =>
    Word(text: text, syllables: syllables, sounds: sounds, image: 'words/$text.svg');

final _cebra = _word('cebra', ['ce', 'bra'], ['se', 'bra']);
final _semilla = _word('semilla', ['se', 'mi', 'lla'], ['se', 'mi', 'ya']);
final _taza = _word('taza', ['ta', 'za'], ['ta', 'sa']);
final _mesa = _word('mesa', ['me', 'sa'], ['me', 'sa']);
final _pina = _word('piña', ['pi', 'ña'], ['pi', 'ña']);
final _dominoAccented = _word('dominó', ['do', 'mi', 'nó'], ['do', 'mi', 'no']);

void main() {
  test('written games need the syllable spelled as shown, listening games only its sound', () {
    expect(PictureSoundGame.startsWith.matches(_cebra, 'se'), isFalse);
    expect(PictureSoundGame.startsWith.matches(_semilla, 'se'), isTrue);
    expect(PictureSoundGame.sameSound.matches(_cebra, 'se'), isTrue);
    expect(PictureSoundGame.endsWith.matches(_taza, 'sa'), isFalse);
    expect(PictureSoundGame.endsWith.matches(_mesa, 'sa'), isTrue);
  });

  test('contains finds the syllable anywhere, ignoring accents', () {
    expect(PictureSoundGame.contains.matches(_pina, 'ña'), isTrue);
    expect(PictureSoundGame.contains.matches(_dominoAccented, 'mi'), isTrue);
    expect(PictureSoundGame.contains.matches(_dominoAccented, 'no'), isTrue);
    expect(PictureSoundGame.contains.matches(_taza, 'sa'), isFalse);
  });

  test('contains rounds offer one picture with the syllable and none that sound like it', () {
    final words = [
      _mesa,
      _taza,
      _pina,
      _word('oso', ['o', 'so'], ['o', 'so']),
      _word('uva', ['u', 'va'], ['u', 'ba']),
      _word('luna', ['lu', 'na'], ['lu', 'na']),
      _word('pato', ['pa', 'to'], ['pa', 'to']),
    ];
    final content = ContentBundle(
      words: words,
      stages: const [
        PathStage(
          stage: 4,
          name: 'montaña',
          steps: [
            PathStep(id: 'sa', sounds: ['sa', 'so'], activities: ['syllables.contains']),
          ],
        ),
      ],
      prompts: testPrompts,
    );

    final items = PictureSoundActivity.contains
        .buildItems(
          ActivityContext(content: content, step: content.stepById('sa')!, random: Random(2)),
        )
        .cast<PictureItem>();

    expect(items, hasLength(PictureSoundActivity.rounds));
    for (final item in items) {
      expect(item.promptId, 'syllables.contains.${item.sound}');
      final target = words.firstWhere((word) => word.text == item.target);
      expect(target.syllables, contains(item.sound));
      final others = item.options.where((option) => option != item.target);
      expect(
        others.every(
          (text) => !words.firstWhere((w) => w.text == text).sounds.contains(item.sound),
        ),
        isTrue,
      );
    }
  });
}
