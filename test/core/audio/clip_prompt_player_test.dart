import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/audio/clip_prompt_player.dart';
import 'package:lee_con_leo/core/audio/clip_speaker.dart';
import 'package:lee_con_leo/core/audio/utterance.dart';
import 'package:lee_con_leo/core/content/models/spoken_line.dart';

import '../../fakes/recording_prompt_player.dart';

class FakeClipSpeaker implements ClipSpeaker {
  final List<String> played = [];
  final Map<String, ClipResult> results = {};
  bool holds = false;
  Completer<void>? _current;
  int stops = 0;

  void finish() => _current?.complete();

  @override
  Future<ClipResult> play(String clip) async {
    played.add(clip);
    if (holds) {
      _current = Completer<void>();
      await _current!.future;
    }
    return results[clip] ?? ClipResult.played;
  }

  @override
  Future<void> stop() async {
    stops++;
    if (_current != null && !_current!.isCompleted) _current!.complete();
  }
}

Utterance clips(List<String> names) =>
    Utterance([for (final name in names) SpokenLine(name, clip: '$name.m4a')]);

void main() {
  late FakeClipSpeaker speaker;
  late RecordingPromptPlayer fallback;
  late ClipPromptPlayer player;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUp(() {
    speaker = FakeClipSpeaker();
    fallback = RecordingPromptPlayer();
    player = ClipPromptPlayer(speaker: speaker, fallback: fallback);
  });

  test('plays every clip of an utterance in order', () async {
    await player.say(clips(['retry', 'say up']));

    expect(speaker.played, ['retry.m4a', 'say up.m4a']);
    expect(fallback.spoken, isEmpty);
  });

  test('an utterance with a part that has no clip is spoken by the fallback', () async {
    await player.say(
      Utterance([const SpokenLine('retry', clip: 'retry.m4a'), const SpokenLine('new phrase')]),
    );

    expect(speaker.played, isEmpty);
    expect(fallback.spoken, ['retry new phrase']);
  });

  test('a clip that fails hands the whole utterance to the fallback', () async {
    speaker.results['broken.m4a'] = ClipResult.failed;

    await player.say(clips(['broken']));

    expect(fallback.spoken, ['broken']);
  });

  test('a clip the browser blocks plays after the first tap', () async {
    speaker.results['intro.m4a'] = ClipResult.blocked;
    await player.say(clips(['intro']));

    speaker.results.clear();
    player.resumeAfterUserGesture();
    await settle();

    expect(speaker.played, ['intro.m4a', 'intro.m4a']);
  });

  test('keeps only the latest utterance requested while one plays', () async {
    speaker.holds = true;
    player.say(clips(['one']));
    await settle();
    player.say(clips(['two']));
    player.say(clips(['three']));

    speaker.finish();
    await settle();
    speaker.finish();
    await settle();

    expect(speaker.played, ['one.m4a', 'three.m4a']);
  });

  test('stop cuts the current utterance and a newer one still plays', () async {
    speaker.holds = true;
    player.say(clips(['reward', 'extra']));
    await settle();
    player.say(clips(['home intro']));
    await player.stop();
    await settle();
    speaker.finish();
    await settle();

    expect(speaker.played, ['reward.m4a', 'home intro.m4a']);
    expect(fallback.calls, contains(RecordingPromptPlayer.stopCall));
  });
}
