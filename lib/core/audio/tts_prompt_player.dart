import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'prompt_player.dart';

class TtsPromptPlayer implements PromptPlayer {
  TtsPromptPlayer({
    FlutterTts? tts,
    this.speechRate = defaultSpeechRate,
    this.voiceLookupAttempts = 20,
    this.voiceLookupInterval = const Duration(milliseconds: 100),
    this.maxUtteranceDuration = const Duration(seconds: 10),
  }) : _tts = tts ?? FlutterTts() {
    _tts
      ..setCompletionHandler(_finishUtterance)
      ..setCancelHandler(_finishUtterance)
      ..setErrorHandler((_) => _finishUtterance());
  }

  static const preferredLanguages = ['es-CL', 'es-US', 'es-MX', 'es-ES'];
  static const defaultSpeechRate = kIsWeb ? 0.9 : 0.45;

  final FlutterTts _tts;
  final double speechRate;
  final int voiceLookupAttempts;
  final Duration voiceLookupInterval;
  final Duration maxUtteranceDuration;
  Future<bool>? _setup;
  Completer<void>? _utterance;
  String? _pending;
  bool _isSpeaking = false;

  @override
  Future<void> say(String text) async {
    if (text.isEmpty) return;
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
    _pending = null;
    _finishUtterance();
    await _tts.stop();
  }

  String? _takePending() {
    final text = _pending;
    _pending = null;
    return text;
  }

  Future<void> _speakAndWait(String text) async {
    final utterance = _utterance = Completer<void>();
    await _tts.speak(text);
    await utterance.future.timeout(maxUtteranceDuration, onTimeout: () {});
    _utterance = null;
  }

  void _finishUtterance() {
    final utterance = _utterance;
    if (utterance != null && !utterance.isCompleted) utterance.complete();
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
