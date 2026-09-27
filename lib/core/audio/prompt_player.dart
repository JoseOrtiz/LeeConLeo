import 'utterance.dart';

abstract interface class PromptPlayer {
  Future<void> prepare();

  Future<void> say(Utterance utterance);

  Future<void> stop();

  void resumeAfterUserGesture();
}
