import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'clip_speaker.dart';

class AssetClipSpeaker implements ClipSpeaker {
  AssetClipSpeaker({AudioPlayer? player, this.maxClipDuration = const Duration(seconds: 15)})
    : _player = player ?? AudioPlayer();

  static const assetFolder = 'audio';
  static const browserBlock = 'NotAllowedError';

  final AudioPlayer _player;
  final Duration maxClipDuration;

  @override
  Future<ClipResult> play(String clip) async {
    final ended = _player.onPlayerStateChanged.firstWhere(
      (state) => state == PlayerState.completed || state == PlayerState.stopped,
    );
    try {
      await _player.play(AssetSource('$assetFolder/$clip'));
      await ended.timeout(maxClipDuration, onTimeout: () => PlayerState.completed);
      return ClipResult.played;
    } catch (error) {
      debugPrint('Clip failed: $clip ($error)');
      return error.toString().contains(browserBlock) ? ClipResult.blocked : ClipResult.failed;
    }
  }

  @override
  Future<void> stop() => _player.stop();
}
