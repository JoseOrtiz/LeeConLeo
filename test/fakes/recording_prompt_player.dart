import 'package:lee_con_leo/core/audio/prompt_player.dart';

class RecordingPromptPlayer implements PromptPlayer {
  final List<String> spoken = [];

  @override
  Future<void> prepare() async {}

  @override
  Future<void> say(String text) async => spoken.add(text);

  @override
  Future<void> stop() async {}

  @override
  void resumeAfterUserGesture() {}
}
