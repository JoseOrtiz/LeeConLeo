import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FakeFlutterTts extends Fake implements FlutterTts {
  FakeFlutterTts({
    this.languages = const {'es-US'},
    this.lookupsBeforeVoicesLoad = 0,
    this.finishesImmediately = true,
  });

  final Set<String> languages;
  int lookupsBeforeVoicesLoad;
  final bool finishesImmediately;
  String? language;
  double? speechRate;
  final List<String> spoken = [];
  VoidCallback? _onFinished;

  void finishSpeaking() => _onFinished?.call();

  @override
  void setCompletionHandler(VoidCallback callback) => _onFinished = callback;

  @override
  void setCancelHandler(VoidCallback callback) {}

  @override
  void setErrorHandler(ErrorHandler handler) {}

  @override
  Future<dynamic> isLanguageAvailable(String language) async {
    if (lookupsBeforeVoicesLoad > 0) {
      lookupsBeforeVoicesLoad--;
      return false;
    }
    return languages.contains(language);
  }

  @override
  Future<dynamic> setLanguage(String language) async => this.language = language;

  @override
  Future<dynamic> setSpeechRate(double rate) async => speechRate = rate;

  @override
  Future<dynamic> speak(String text, {bool focus = false}) async {
    spoken.add(text);
    if (finishesImmediately) finishSpeaking();
  }

  @override
  Future<dynamic> stop() async {}
}
