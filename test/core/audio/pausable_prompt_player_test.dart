import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/audio/pausable_prompt_player.dart';
import 'package:lee_con_leo/core/audio/utterance.dart';

import '../../fakes/recording_prompt_player.dart';

void main() {
  late RecordingPromptPlayer inner;
  late PausablePromptPlayer player;

  setUp(() {
    inner = RecordingPromptPlayer();
    player = PausablePromptPlayer(inner);
  });

  test('pausing stops the current phrase and keeps new ones quiet', () async {
    await player.pause();
    await player.say(Utterance.text('Toca la flecha de arriba.'));

    expect(inner.calls, [RecordingPromptPlayer.stopCall]);
  });

  test('after resuming, Leo speaks again', () async {
    await player.pause();
    player.resume();
    await player.say(Utterance.text('¡Muy bien!'));

    expect(inner.spoken, ['¡Muy bien!']);
  });
}
