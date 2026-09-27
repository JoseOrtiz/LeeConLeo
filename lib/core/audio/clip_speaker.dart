enum ClipResult { played, blocked, failed }

abstract interface class ClipSpeaker {
  Future<ClipResult> play(String clip);

  Future<void> stop();
}
