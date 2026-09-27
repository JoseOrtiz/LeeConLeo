import 'spanish_letters.dart';

class Syllabifier {
  const Syllabifier();

  static const _digraphs = {'ch', 'll', 'rr', 'qu'};
  static const _clusterStarts = {'p', 'b', 'f', 'c', 'g', 'k', 't', 'd'};

  List<String> split(String text) => [
    for (final word in text.trim().split(RegExp(r'\s+')))
      if (word.isNotEmpty) ..._splitWord(word),
  ];

  List<String> _splitWord(String word) {
    final units = _toUnits(word);
    final nuclei = _findNuclei(units);
    if (nuclei.isEmpty) return [word];

    final boundaries = [
      for (var k = 0; k < nuclei.length - 1; k++)
        _boundaryBetween(units, nuclei[k].end, nuclei[k + 1].start),
      units.length,
    ];

    final syllables = <String>[];
    var start = 0;
    for (final end in boundaries) {
      syllables.add(_join(units.sublist(start, end)));
      start = end;
    }
    return syllables;
  }

  String _join(List<_Unit> units) => units.map((unit) => unit.text).join();

  List<_Unit> _toUnits(String word) {
    final lower = word.toLowerCase();
    String letterAt(int i) => i < lower.length ? lower[i] : '';
    final units = <_Unit>[];
    var i = 0;
    while (i < lower.length) {
      final letter = letterAt(i);
      final pair = letter + letterAt(i + 1);
      final isDigraph =
          _digraphs.contains(pair) ||
          (pair == 'gu' && SpanishLetters.isFrontVowel(letterAt(i + 2)));
      if (isDigraph) {
        units.add(_Unit(word.substring(i, i + 2), isVowel: false, isStrong: false));
        i += 2;
        continue;
      }
      final isVowel = letter == 'y'
          ? !SpanishLetters.isVowel(letterAt(i + 1))
          : SpanishLetters.isVowel(letter);
      units.add(_Unit(word[i], isVowel: isVowel, isStrong: SpanishLetters.isStrongVowel(letter)));
      i++;
    }
    return units;
  }

  List<_Nucleus> _findNuclei(List<_Unit> units) {
    final nuclei = <_Nucleus>[];
    for (var i = 0; i < units.length; i++) {
      if (!units[i].isVowel) continue;
      final continuesNucleus =
          i > 0 && units[i - 1].isVowel && !(units[i - 1].isStrong && units[i].isStrong);
      if (continuesNucleus) {
        nuclei.last.end = i;
      } else {
        nuclei.add(_Nucleus(i));
      }
    }
    return nuclei;
  }

  int _boundaryBetween(List<_Unit> units, int previousNucleusEnd, int nextNucleusStart) {
    final consonants = units.sublist(previousNucleusEnd + 1, nextNucleusStart);
    return previousNucleusEnd + 1 + _codaLength(consonants);
  }

  int _codaLength(List<_Unit> consonants) {
    final count = consonants.length;
    if (count <= 1) return 0;
    final endsWithCluster = _isInseparable(consonants[count - 2].text, consonants[count - 1].text);
    return endsWithCluster ? count - 2 : count - 1;
  }

  bool _isInseparable(String first, String second) {
    final a = first.toLowerCase();
    final b = second.toLowerCase();
    if (!_clusterStarts.contains(a)) return false;
    if (b == 'r') return true;
    return b == 'l' && a != 'd' && a != 't';
  }
}

class _Unit {
  const _Unit(this.text, {required this.isVowel, required this.isStrong});

  final String text;
  final bool isVowel;
  final bool isStrong;
}

class _Nucleus {
  _Nucleus(this.start) : end = start;

  final int start;
  int end;
}
