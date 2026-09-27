import 'dart:io';

class WordsYamlWriter {
  const WordsYamlWriter(this.path);

  final String path;

  void write(List<String> words) {
    final lines = [for (final word in words) '- text: $word'];
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync('${lines.join('\n')}\n');
  }
}
