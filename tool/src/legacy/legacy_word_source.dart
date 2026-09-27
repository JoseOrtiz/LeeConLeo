import 'dart:io';

import 'package:path/path.dart' as p;

class LegacyWordSource {
  const LegacyWordSource(this.assetsDir);

  final String assetsDir;

  static const _listDirs = ['startsWith', 'endsWith', 'joinStartsWith', 'joinEndsWith'];
  static const _mediaDirs = ['pictures', 'picturesSpeech'];
  static final _validName = RegExp(r'^[a-z_]+$');

  Set<String> readWords() {
    final names = [..._namesFromLists(), ..._namesFromMedia()];
    return {
      for (final name in names)
        if (_validName.hasMatch(name)) name.replaceAll('_', ' '),
    };
  }

  Iterable<String> _namesFromLists() => _listDirs
      .expand((dir) => _files(dir))
      .expand((file) => file.readAsStringSync().split(RegExp(r'[,\r\n]+')))
      .map(_normalize);

  Iterable<String> _namesFromMedia() =>
      _mediaDirs.expand((dir) => _files(dir)).map((file) => _normalize(p.basename(file.path)));

  Iterable<File> _files(String dir) {
    final directory = Directory(p.join(assetsDir, dir));
    if (!directory.existsSync()) return const [];
    return directory.listSync().whereType<File>();
  }

  String _normalize(String fileName) => p.basenameWithoutExtension(fileName.trim()).toLowerCase();
}
