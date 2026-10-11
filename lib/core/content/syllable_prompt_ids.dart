import 'activity_ids.dart';

abstract final class SyllablePromptIds {
  static String meet(String syllable) => '${ActivityIds.syllableMeet}.$syllable';

  static String choose(String syllable) => '${meet(syllable)}.choose';

  static String trace(String syllable) => '${ActivityIds.syllableTrace}.$syllable';

  static String find(String syllable) => '${ActivityIds.syllableFind}.$syllable';

  static List<String> requiredFor(String activityId, String syllable) => switch (activityId) {
    ActivityIds.syllableMeet => [meet(syllable), choose(syllable)],
    ActivityIds.syllableTrace => [trace(syllable)],
    ActivityIds.syllableFind => [find(syllable)],
    _ => const [],
  };
}
