import '../bundle_writer.dart';
import '../content_paths.dart';
import '../validation/content_validator.dart';
import '../yaml_content_reader.dart';
import 'content_command.dart';

class BuildCommand implements ContentCommand {
  const BuildCommand({
    this.reader = const YamlContentReader(),
    this.validator = const ContentValidator(),
    this.writer = const BundleWriter(ContentPaths.bundle),
  });

  final YamlContentReader reader;
  final ContentValidator validator;
  final BundleWriter writer;

  @override
  String get name => 'build';

  @override
  String get usage =>
      'build [--check]       write the app bundle; --check only verifies it is current';

  @override
  int run(List<String> arguments) {
    final bundle = reader.read();
    final errors = validator.validate(bundle).where((issue) => issue.isError).toList();
    if (errors.isNotEmpty) {
      errors.forEach(print);
      return 1;
    }

    if (arguments.contains('--check')) {
      final upToDate = writer.isUpToDate(bundle);
      print(
        upToDate
            ? 'Bundle is up to date'
            : 'Bundle is outdated: run "dart run tool/content.dart build"',
      );
      return upToDate ? 0 : 1;
    }

    writer.write(bundle);
    print('Wrote ${writer.path}: ${bundle.words.length} words, ${bundle.steps.length} steps');
    return 0;
  }
}
