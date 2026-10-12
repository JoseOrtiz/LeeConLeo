import 'models/word.dart';
import 'sound_position.dart';

abstract final class ClapWords {
  static const maxSyllables = 4;

  static List<Word> all(Iterable<Word> words) => [
    for (final word in SoundPosition.pictured(words))
      if (word.audio != null && word.syllables.isNotEmpty && word.syllables.length <= maxSyllables)
        word,
  ];
}
