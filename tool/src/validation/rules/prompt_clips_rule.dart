import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';

import '../validation_issue.dart';
import '../validation_rule.dart';

class PromptClipsRule implements ValidationRule {
  const PromptClipsRule();

  @override
  Iterable<ValidationIssue> check(ContentBundle bundle) sync* {
    final prompts = bundle.prompts;
    final keys = {
      for (final MapEntry(key: id, value: variants) in prompts.phrases.entries)
        for (var index = 0; index < variants.length; index++) PromptLibrary.clipKey(id, index),
    };
    for (final MapEntry(key: key, value: file) in prompts.clips.entries) {
      if (!keys.contains(key)) {
        yield ValidationIssue.error('clip "$file" matches no prompt variant "$key"');
      }
    }
    for (final key in keys.where((key) => !prompts.clips.containsKey(key))) {
      yield ValidationIssue.error('phrase "$key" has no recorded clip');
    }
  }
}
