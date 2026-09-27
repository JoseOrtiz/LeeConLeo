abstract interface class PromptPlayer {
  Future<void> prepare();

  Future<void> say(String text);

  Future<void> stop();

  void resumeAfterUserGesture();
}
