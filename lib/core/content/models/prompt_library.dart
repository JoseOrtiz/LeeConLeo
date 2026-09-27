import 'dart:math';

class PromptLibrary {
  const PromptLibrary(this.phrases);

  factory PromptLibrary.fromJson(Map<String, dynamic> json) => PromptLibrary({
    for (final entry in json.entries) entry.key: (entry.value as List).cast<String>(),
  });

  final Map<String, List<String>> phrases;

  bool contains(String id) => phrases.containsKey(id);

  String pick(String id, Random random) {
    final options = phrases[id];
    if (options == null || options.isEmpty) return '';
    return options[random.nextInt(options.length)];
  }

  Map<String, dynamic> toJson() => phrases;
}
