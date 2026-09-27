import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  }) : _tts = tts ?? FlutterTts() {
    _tts
      ..setCompletionHandler(() => _finishUtterance(spoken: true))
      ..setCancelHandler(() => _finishUtterance(spoken: true))
      ..setErrorHandler(_onError);
  }

  static const preferredLanguages = ['es-CL', 'es-US', 'es-MX', 'es-ES'];
  static const defaultSpeechRate = kIsWeb ? 0.9 : 0.45;
  static const blockedByBrowser = 'not-allowed';

  final FlutterTts _tts;
  final double speechRate;
  final int voiceLookupAttempts;
  final Duration voiceLookupInterval;
  final Duration maxUtteranceDuration;
  final int retriesAfterError;
  final Duration retryDelay;
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
    _pending = null;
    _blocked = null;
    _finishUtterance(spoken: true);
    await _tts.stop();
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
      final spoken = await utterance.future.timeout(maxUtteranceDuration, onTimeout: () => true);
      _utterance = null;
      if (spoken) return;
      if (_lastErrorWasBlock) {
        _blocked = text;
        return;
      }
    }
  }

  void _onError(dynamic message) {
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
    final language = await _findSpanishLanguage();
    if (language == null) return false;
    await _tts.setLanguage(language);
    return true;
  }

  Future<String?> _findSpanishLanguage() async {
    for (var attempt = 0; attempt < voiceLookupAttempts; attempt++) {
      if (attempt > 0) await Future<void>.delayed(voiceLookupInterval);
      for (final language in preferredLanguages) {
        if (await _tts.isLanguageAvailable(language) == true) return language;
      }
    }
    return null;
  }
}
