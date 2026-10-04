import 'package:flutter/foundation.dart';

import 'clip_speaker.dart';
import 'prompt_player.dart';
import 'utterance.dart';

class ClipPromptPlayer implements PromptPlayer {
  ClipPromptPlayer({required ClipSpeaker speaker}) : _speaker = speaker;

  final ClipSpeaker _speaker;
  Utterance? _pending;
  Utterance? _blocked;
  bool _isPlaying = false;
  int _stops = 0;

  @override
  Future<void> say(Utterance utterance) async {
    if (utterance.isEmpty) return;
    _blocked = null;
    if (!utterance.hasAllClips) {
      debugPrint('No recorded clip for "${utterance.text}"');
      return;
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
  }

  @override
  void resumeAfterUserGesture() {
    final blocked = _blocked;
    if (blocked != null) say(blocked);
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
      if (_stops != stops || result == ClipResult.failed) return;
      if (result == ClipResult.blocked) {
        _blocked = utterance;
        return;
      }
    }
  }
}
