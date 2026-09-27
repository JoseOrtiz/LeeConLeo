import 'package:lee_con_leo/core/audio/prompt_player.dart';

class RecordingPromptPlayer implements PromptPlayer {
  static const stopCall = '<stop>';

  final List<String> spoken = [];
  final List<String> calls = [];

  @override
  Future<void> prepare() async {}

  @override
  Future<void> say(String text) async {
    spoken.add(text);
    calls.add(text);
  }

  @override
  Future<void> stop() async => calls.add(stopCall);

  @override
  void resumeAfterUserGesture() {}
}
