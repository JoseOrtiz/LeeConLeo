import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../utils/voice_picker.dart';
import 'prompt_player.dart';

class TtsPromptPlayer implements PromptPlayer {
  TtsPromptPlayer({
    FlutterTts? tts,
    this.speechRate = defaultSpeechRate,
    this.voiceLookupAttempts = 80,
    this.voiceLookupInterval = const Duration(milliseconds: 100),
    this.maxUtteranceDuration = const Duration(seconds: 10),
    this.retriesAfterError = 2,
    this.retryDelay = const Duration(milliseconds: 500),
    this.stopSettleDelay = const Duration(milliseconds: 200),
  }) : _tts = tts ?? FlutterTts() {
    _tts
      ..setCompletionHandler(() => _finishUtterance(spoken: true))
      ..setCancelHandler(() => _finishUtterance(spoken: true))
      ..setErrorHandler(_onError);
  }

  static const preferredLanguages = ['es-CL', 'es-US', 'es-MX', 'es-ES'];
  static const defaultSpeechRate = kIsWeb ? 0.9 : 0.45;
  static const blockedByBrowser = 'not-allowed';
  static const cutOnPurpose = {'interrupted', 'canceled'};

  final FlutterTts _tts;
  final double speechRate;
  final int voiceLookupAttempts;
  final Duration voiceLookupInterval;
  final Duration maxUtteranceDuration;
  final int retriesAfterError;
  final Duration retryDelay;
  final Duration stopSettleDelay;
  Future<bool>? _setup;
  Completer<bool>? _utterance;
  String? _pending;
  bool _isSpeaking = false;
  int _stops = 0;
  bool _lastErrorWasBlock = false;
  String? _blocked;

  @override
  Future<void> prepare() => _ensureConfigured();

  @override
  void resumeAfterUserGesture() {
    final text = _blocked;
    if (text != null) say(text);
  }

  @override
  Future<void> say(String text) async {
    if (text.isEmpty) return;
    _blocked = null;
    _pending = text;
    if (_isSpeaking) return;
    _isSpeaking = true;
    try {
      await _ensureConfigured();
      for (var next = _takePending(); next != null; next = _takePending()) {
        await _speakAndWait(next);
      }
    } finally {
      _isSpeaking = false;
    }
  }

  @override
  Future<void> stop() async {
    _stops++;
    _blocked = null;
    await _tts.stop();
    await Future<void>.delayed(stopSettleDelay);
    _finishUtterance(spoken: true);
  }

  String? _takePending() {
    final text = _pending;
    _pending = null;
    return text;
  }

  Future<void> _speakAndWait(String text) async {
    final stops = _stops;
    for (var attempt = 0; attempt <= retriesAfterError; attempt++) {
      if (attempt > 0) {
        await Future<void>.delayed(retryDelay);
        if (_stops != stops || _pending != null) return;
      }
      final utterance = _utterance = Completer<bool>();
      await _tts.speak(text);
      final spoken = await utterance.future.timeout(maxUtteranceDuration, onTimeout: _reset);
      _utterance = null;
      if (spoken) return;
      if (_lastErrorWasBlock) {
        _blocked = text;
        return;
      }
    }
  }

  Future<bool> _reset() async {
    debugPrint('Speech did not finish in time; resetting the speech engine');
    await _tts.stop();
    return true;
  }

  void _onError(dynamic message) {
    if (cutOnPurpose.contains(message)) {
      _finishUtterance(spoken: true);
      return;
    }
    debugPrint('Speech failed: $message');
    _lastErrorWasBlock = message == blockedByBrowser;
    _finishUtterance(spoken: false);
  }

  void _finishUtterance({required bool spoken}) {
    final utterance = _utterance;
    if (utterance != null && !utterance.isCompleted) utterance.complete(spoken);
  }

  Future<void> _ensureConfigured() async {
    final setup = _setup ??= _configure();
    if (!await setup) _setup = null;
  }

  Future<bool> _configure() async {
    await _tts.setSpeechRate(speechRate);
    final voice = await _findSpanishVoice();
    if (voice == null) {
      debugPrint('Speech: no Spanish voice found yet');
      return false;
    }
    debugPrint('Speech voice: ${voice.name} (${voice.locale})');
    await _tts.setLanguage(voice.locale);
    await _tts.setVoice({'name': voice.name, 'locale': voice.locale});
    return true;
  }

  Future<Voice?> _findSpanishVoice() async {
    for (var attempt = 0; attempt < voiceLookupAttempts; attempt++) {
      if (attempt > 0) await Future<void>.delayed(voiceLookupInterval);
      final voice = pickVoice(await _availableVoices(), preferredLanguages);
      if (voice != null) return voice;
    }
    return null;
  }

  Future<List<Voice>> _availableVoices() async {
    final voices = await _tts.getVoices;
    if (voices is! List) return const [];
    return [
      for (final voice in voices)
        if (voice case {'name': final String name, 'locale': final String locale})
          Voice(name: name, locale: locale),
    ];
  }
}
