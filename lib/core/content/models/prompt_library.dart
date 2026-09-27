import 'dart:math';

import 'spoken_line.dart';

class PromptLibrary {
  const PromptLibrary(this.phrases, {this.clips = const {}});

  factory PromptLibrary.fromJson(
    Map<String, dynamic> json, {
    Map<String, String> clips = const {},
  }) => PromptLibrary({
    for (final entry in json.entries) entry.key: (entry.value as List).cast<String>(),
  }, clips: clips);

  final Map<String, List<String>> phrases;
  final Map<String, String> clips;

  static String clipKey(String id, int index) => '$id.$index';

  bool contains(String id) => phrases.containsKey(id);

  SpokenLine line(String id, Random random) {
    final options = phrases[id];
    if (options == null || options.isEmpty) return const SpokenLine('');
    final index = random.nextInt(options.length);
    return SpokenLine(options[index], clip: clips[clipKey(id, index)]);
  }

  String pick(String id, Random random) => line(id, random).text;

  Map<String, dynamic> toJson() => phrases;
}
