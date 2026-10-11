abstract final class SoundClips {
  static const dir = 'sounds';

  static String of(String sound) => '$dir/${sound.length == 1 ? 'vowel' : 'syllable'}.$sound.m4a';
}
