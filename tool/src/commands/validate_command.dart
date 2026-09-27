import '../validation/content_validator.dart';
import '../yaml_content_reader.dart';
import 'content_command.dart';

class ValidateCommand implements ContentCommand {
  const ValidateCommand({
    this.reader = const YamlContentReader(),
    this.validator = const ContentValidator(),
  });

  final YamlContentReader reader;
  final ContentValidator validator;

  @override
  String get name => 'validate';

  @override
  String get usage => 'validate [--strict]   check content; --strict also fails on warnings';

  @override
  int run(List<String> arguments) {
    final strict = arguments.contains('--strict');
    final issues = validator.validate(reader.read());
    final errors = issues.where((issue) => issue.isError).length;
    final warnings = issues.length - errors;

    issues.forEach(print);
    print('$errors error(s), $warnings warning(s)');

    return errors > 0 || (strict && warnings > 0) ? 1 : 0;
  }
}
