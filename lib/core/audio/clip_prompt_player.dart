import 'clip_speaker.dart';
import 'prompt_player.dart';
import 'utterance.dart';

class ClipPromptPlayer implements PromptPlayer {
  ClipPromptPlayer({required ClipSpeaker speaker, required PromptPlayer fallback})
    : _speaker = speaker,
      _fallback = fallback;

  final ClipSpeaker _speaker;
  final PromptPlayer _fallback;
  Utterance? _pending;
  Utterance? _blocked;
  bool _isPlaying = false;
  int _stops = 0;

  @override
  Future<void> prepare() => _fallback.prepare();

  @override
  Future<void> say(Utterance utterance) async {
    if (utterance.isEmpty) return;
    _blocked = null;
    if (!utterance.hasAllClips) {
      _pending = null;
      await _speaker.stop();
      return _fallback.say(utterance);
    }
    _pending = utterance;
    if (_isPlaying) return;
    _isPlaying = true;
    try {
      for (var next = _takePending(); next != null; next = _takePending()) {
        await _play(next);
      }
    } finally {
      _isPlaying = false;
    }
  }

  @override
  Future<void> stop() async {
    _stops++;
    _blocked = null;
    await _speaker.stop();
    await _fallback.stop();
  }

  @override
  void resumeAfterUserGesture() {
    final blocked = _blocked;
    if (blocked != null) say(blocked);
    _fallback.resumeAfterUserGesture();
  }

  Utterance? _takePending() {
    final utterance = _pending;
    _pending = null;
    return utterance;
  }

  Future<void> _play(Utterance utterance) async {
    final stops = _stops;
    for (final line in utterance.lines) {
      final result = await _speaker.play(line.clip!);
      if (_stops != stops) return;
      if (result == ClipResult.blocked) {
        _blocked = utterance;
        return;
      }
      if (result == ClipResult.failed) {
        await _fallback.say(utterance);
        return;
      }
    }
  }
}
