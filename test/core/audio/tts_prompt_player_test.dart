import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/audio/tts_prompt_player.dart';

import '../../fakes/fake_flutter_tts.dart';

void main() {
  TtsPromptPlayer playerWith(
    FakeFlutterTts tts, {
    Duration maxUtteranceDuration = const Duration(seconds: 10),
  }) => TtsPromptPlayer(
    tts: tts,
    voiceLookupAttempts: 3,
    voiceLookupInterval: Duration.zero,
    maxUtteranceDuration: maxUtteranceDuration,
    retryDelay: Duration.zero,
    stopSettleDelay: Duration.zero,
  );

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('picks the first preferred Spanish language that is available', () async {
    final tts = FakeFlutterTts(languages: {'es-ES', 'es-MX'});

    await playerWith(tts).sayText('Hola');

    expect(tts.language, 'es-MX');
    expect(tts.voice, 'Local es-MX');
    expect(tts.speechRate, TtsPromptPlayer.defaultSpeechRate);
    expect(tts.spoken, ['Hola']);
  });

  test('prepare picks the voice before anything is spoken', () async {
    final tts = FakeFlutterTts(languages: {'es-US'});

    await playerWith(tts).prepare();

    expect(tts.language, 'es-US');
    expect(tts.spoken, isEmpty);
  });

  test('waits for voices that load after the first lookup', () async {
    final tts = FakeFlutterTts(languages: {'es-US'}, lookupsBeforeVoicesLoad: 2);

    await playerWith(tts).sayText('Hola');

    expect(tts.language, 'es-US');
  });

  test('tries again on the next prompt when no Spanish voice was found', () async {
    final tts = FakeFlutterTts(languages: {'es-US'}, lookupsBeforeVoicesLoad: 100);
    final player = playerWith(tts);

    await player.sayText('Hola');
    expect(tts.language, isNull);

    tts.lookupsBeforeVoicesLoad = 0;
    await player.sayText('Arriba');

    expect(tts.language, 'es-US');
    expect(tts.spoken, ['Hola', 'Arriba']);
  });

  test('speaks the next prompt after the current one finishes', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.sayText('¡Excelente!');
    await settle();
    player.sayText('¿Dónde está arriba?');
    await settle();
    expect(tts.spoken, ['¡Excelente!']);

    tts.finishSpeaking();
    await settle();
    expect(tts.spoken, ['¡Excelente!', '¿Dónde está arriba?']);
  });

  test('keeps only the latest prompt requested while speaking', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.sayText('Uno');
    await settle();
    player.sayText('Dos');
    player.sayText('Tres');
    tts.finishSpeaking();
    await settle();

    expect(tts.spoken, ['Uno', 'Tres']);
  });

  test('a lost end-of-speech event does not block later prompts', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts, maxUtteranceDuration: const Duration(milliseconds: 10));

    player.sayText('Uno');
    await settle();
    player.sayText('Dos');
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(tts.spoken, ['Uno', 'Dos']);
    expect(tts.stops, greaterThanOrEqualTo(1));
  });

  test('a phrase that fails is spoken again', () async {
    final tts = FakeFlutterTts(failures: 1);

    await playerWith(tts).sayText('Hola');

    expect(tts.spoken, ['Hola', 'Hola']);
  });

  test('a phrase that keeps failing is retried only twice', () async {
    final tts = FakeFlutterTts(failures: 10);

    await playerWith(tts).sayText('Hola');

    expect(tts.spoken, ['Hola', 'Hola', 'Hola']);
  });

  test('a phrase the browser blocks is said after the first tap', () async {
    final tts = FakeFlutterTts(failures: 1, failure: TtsPromptPlayer.blockedByBrowser);
    final player = playerWith(tts);

    await player.sayText('Hola');
    expect(tts.spoken, ['Hola']);

    player.resumeAfterUserGesture();
    await settle();
    expect(tts.spoken, ['Hola', 'Hola']);

    player.resumeAfterUserGesture();
    await settle();
    expect(tts.spoken, ['Hola', 'Hola']);
  });

  test('a newer phrase replaces the blocked one', () async {
    final tts = FakeFlutterTts(failures: 1, failure: TtsPromptPlayer.blockedByBrowser);
    final player = playerWith(tts);

    await player.sayText('Hola');
    await player.sayText('Arriba');
    player.resumeAfterUserGesture();
    await settle();

    expect(tts.spoken, ['Hola', 'Arriba']);
  });

  test('stop cuts the current phrase and a newer one still plays', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.sayText('¡Terminaste!');
    await settle();
    player.sayText('¡Hola! Soy Leo.');
    await player.stop();
    await settle();

    expect(tts.spoken, ['¡Terminaste!', '¡Hola! Soy Leo.']);
    expect(tts.stops, 1);
  });

  test('a phrase cut on purpose is not retried', () async {
    final tts = FakeFlutterTts(failures: 1, failure: 'interrupted');

    await playerWith(tts).sayText('Hola');

    expect(tts.spoken, ['Hola']);
  });
}
