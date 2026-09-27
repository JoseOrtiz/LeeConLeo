import '../content/models/spoken_line.dart';

class Utterance {
  const Utterance(this.lines);

  Utterance.text(String text) : lines = [SpokenLine(text)];

  final List<SpokenLine> lines;

  String get text => [
    for (final line in lines)
      if (line.text.isNotEmpty) line.text,
  ].join(' ');

  bool get isEmpty => text.isEmpty;

  bool get hasAllClips => lines.isNotEmpty && lines.every((line) => line.clip != null);
}
