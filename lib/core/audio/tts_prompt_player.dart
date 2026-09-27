import 'package:flutter_tts/flutter_tts.dart';

import 'prompt_player.dart';

class TtsPromptPlayer implements PromptPlayer {
  TtsPromptPlayer({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  static const preferredLanguages = ['es-CL', 'es-US', 'es-MX', 'es-ES'];
  static const speechRate = 0.45;

  final FlutterTts _tts;
  Future<void>? _setup;

  @override
  Future<void> say(String text) async {
    if (text.isEmpty) return;
    await (_setup ??= _configure());
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  Future<void> stop() => _tts.stop();

  Future<void> _configure() async {
    for (final language in preferredLanguages) {
      if (await _tts.isLanguageAvailable(language) == true) {
        await _tts.setLanguage(language);
        break;
      }
    }
    await _tts.setSpeechRate(speechRate);
  }
}
