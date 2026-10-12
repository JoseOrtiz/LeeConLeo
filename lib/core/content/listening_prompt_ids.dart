import 'activity_ids.dart';

abstract final class ListeningPromptIds {
  static const clapAsk = '${ActivityIds.clap}.ask';

  static String clapSplit(String word) => '${ActivityIds.clap}.$word';
}
