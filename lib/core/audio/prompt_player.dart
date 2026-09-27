abstract interface class PromptPlayer {
  Future<void> say(String text);

  Future<void> stop();
}
