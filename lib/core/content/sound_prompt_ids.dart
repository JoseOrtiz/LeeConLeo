import 'activity_ids.dart';

abstract final class SoundPromptIds {
  static String startsWith(String sound) => '${ActivityIds.startsWith}.$sound';

  static String endsWith(String sound) => '${ActivityIds.endsWith}.$sound';

  static String contains(String sound) => '${ActivityIds.contains}.$sound';
}
