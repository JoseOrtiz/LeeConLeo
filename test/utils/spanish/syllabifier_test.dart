import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/utils/spanish/syllabifier.dart';

void main() {
  const syllabifier = Syllabifier();

  const cases = {
    'mano': 'ma-no',
    'perro': 'pe-rro',
    'llave': 'lla-ve',
    'chancho': 'chan-cho',
    'cielo': 'cie-lo',
    'guitarra': 'gui-ta-rra',
    'pingüino': 'pin-güi-no',
    'queso': 'que-so',
    'blanco': 'blan-co',
    'instante': 'ins-tan-te',
    'extraño': 'ex-tra-ño',
    'atleta': 'at-le-ta',
    'aéreo': 'a-é-re-o',
    'país': 'pa-ís',
    'búho': 'bú-ho',
    'rey': 'rey',
    'yate': 'ya-te',
    'murciélago': 'mur-cié-la-go',
    'teléfono': 'te-lé-fo-no',
    'tren': 'tren',
    'estrella de mar': 'es-tre-lla-de-mar',
  };

  cases.forEach((word, expected) {
    test('$word → $expected', () {
      expect(syllabifier.split(word).join('-'), expected);
    });
  });
}
