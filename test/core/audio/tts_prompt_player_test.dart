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
  );

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('picks the first preferred Spanish language that is available', () async {
    final tts = FakeFlutterTts(languages: {'es-ES', 'es-MX'});

    await playerWith(tts).say('Hola');

    expect(tts.language, 'es-MX');
    expect(tts.speechRate, TtsPromptPlayer.defaultSpeechRate);
    expect(tts.spoken, ['Hola']);
  });

  test('waits for voices that load after the first lookup', () async {
    final tts = FakeFlutterTts(languages: {'es-US'}, lookupsBeforeVoicesLoad: 8);

    await playerWith(tts).say('Hola');

    expect(tts.language, 'es-US');
  });

  test('tries again on the next prompt when no Spanish voice was found', () async {
    final tts = FakeFlutterTts(languages: {'es-US'}, lookupsBeforeVoicesLoad: 100);
    final player = playerWith(tts);

    await player.say('Hola');
    expect(tts.language, isNull);

    tts.lookupsBeforeVoicesLoad = 0;
    await player.say('Arriba');

    expect(tts.language, 'es-US');
    expect(tts.spoken, ['Hola', 'Arriba']);
  });

  test('speaks the next prompt after the current one finishes', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.say('¡Excelente!');
    await settle();
    player.say('¿Dónde está arriba?');
    await settle();
    expect(tts.spoken, ['¡Excelente!']);

    tts.finishSpeaking();
    await settle();
    expect(tts.spoken, ['¡Excelente!', '¿Dónde está arriba?']);
  });

  test('keeps only the latest prompt requested while speaking', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.say('Uno');
    await settle();
    player.say('Dos');
    player.say('Tres');
    tts.finishSpeaking();
    await settle();

    expect(tts.spoken, ['Uno', 'Tres']);
  });

  test('a lost end-of-speech event does not block later prompts', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts, maxUtteranceDuration: const Duration(milliseconds: 10));

    player.say('Uno');
    await settle();
    player.say('Dos');
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(tts.spoken, ['Uno', 'Dos']);
  });

  test('stop drops a prompt that is waiting', () async {
    final tts = FakeFlutterTts(finishesImmediately: false);
    final player = playerWith(tts);

    player.say('Uno');
    await settle();
    player.say('Dos');
    await player.stop();
    await settle();

    expect(tts.spoken, ['Uno']);
  });
}
