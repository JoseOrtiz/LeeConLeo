import 'activity_ids.dart';
import 'models/word.dart';
import 'sound_prompt_ids.dart';

enum SoundPosition {
  start(ActivityIds.startsWith),
  end(ActivityIds.endsWith);

  const SoundPosition(this.activityId);

  final String activityId;

  bool matches(Word word, String sound) =>
      this == start ? word.startsWithSound(sound) : word.endsWithSound(sound);

  String promptId(String sound) =>
      this == start ? SoundPromptIds.startsWith(sound) : SoundPromptIds.endsWith(sound);

  static List<Word> pictured(Iterable<Word> words) =>
      words.where((word) => word.image != null).toList();
}
