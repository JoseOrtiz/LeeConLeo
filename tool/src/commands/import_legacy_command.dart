import 'dart:io';

import '../content_paths.dart';
import '../legacy/legacy_word_corrections.dart';
import '../legacy/legacy_word_source.dart';
import '../legacy/words_yaml_writer.dart';
import 'content_command.dart';

class ImportLegacyCommand implements ContentCommand {
  const ImportLegacyCommand({this.corrections = const LegacyWordCorrections()});

  final LegacyWordCorrections corrections;

  @override
  String get name => 'import-legacy';

  @override
  String get usage => 'import-legacy <dir>   draft words.yaml from the 2014 app assets folder';

  @override
  int run(List<String> arguments) {
    if (arguments.isEmpty) {
      print('Usage: $usage');
      return 64;
    }
    if (File(ContentPaths.words).existsSync()) {
      print('${ContentPaths.words} already exists; remove it first to re-import');
      return 1;
    }

    final words = corrections.apply(LegacyWordSource(arguments.first).readWords());
    const WordsYamlWriter(ContentPaths.words).write(words);
    print('Wrote ${ContentPaths.words}: ${words.length} words');
    return 0;
  }
}
