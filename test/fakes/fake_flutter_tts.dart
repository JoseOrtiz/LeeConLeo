import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FakeFlutterTts extends Fake implements FlutterTts {
  FakeFlutterTts({
    this.languages = const {'es-US'},
    this.lookupsBeforeVoicesLoad = 0,
    this.finishesImmediately = true,
    this.failures = 0,
    this.failure = 'synthesis-failed',
  });

  final String failure;

  final Set<String> languages;
  int lookupsBeforeVoicesLoad;
  final bool finishesImmediately;
  int failures;
  String? language;
  String? voice;
  double? speechRate;
  final List<String> spoken = [];
  int stops = 0;
  VoidCallback? _onFinished;
  ErrorHandler? _onError;

  void finishSpeaking() => _onFinished?.call();

  @override
  void setCompletionHandler(VoidCallback callback) => _onFinished = callback;

  @override
  void setCancelHandler(VoidCallback callback) {}

  @override
  void setErrorHandler(ErrorHandler handler) => _onError = handler;

  @override
  Future<dynamic> get getVoices async {
    if (lookupsBeforeVoicesLoad > 0) {
      lookupsBeforeVoicesLoad--;
      return <Object?>[];
    }
    return [
      for (final language in languages) {'name': 'Local $language', 'locale': language},
    ];
  }

  @override
  Future<dynamic> setLanguage(String language) async => this.language = language;

  @override
  Future<dynamic> setVoice(Map<String, String> voice) async => this.voice = voice['name'];

  @override
  Future<dynamic> setSpeechRate(double rate) async => speechRate = rate;

  @override
  Future<dynamic> speak(String text, {bool focus = false}) async {
    spoken.add(text);
    if (failures > 0) {
      failures--;
      _onError?.call(failure);
    } else if (finishesImmediately) {
      finishSpeaking();
    }
  }

  @override
  Future<dynamic> stop() async => stops++;
}
