import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/word.dart';

void main() {
  test('a word starts with a sound when its first syllable begins with it', () {
    const arbol = Word(text: 'árbol', syllables: ['ár', 'bol'], sounds: ['ar', 'bol']);
    const helado = Word(text: 'helado', syllables: ['he', 'la', 'do'], sounds: ['e', 'la', 'do']);

    expect(arbol.startsWithSound('a'), isTrue);
    expect(arbol.startsWithSound('ar'), isTrue);
    expect(arbol.startsWithSound('o'), isFalse);
    expect(helado.startsWithSound('e'), isTrue);
  });
}
