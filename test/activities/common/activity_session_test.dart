import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/activity_item.dart';
import 'package:lee_con_leo/activities/common/activity_session.dart';
import 'package:lee_con_leo/core/logging/in_memory_event_log.dart';

import '../../fakes/recording_prompt_player.dart';
import '../../fakes/test_content.dart';

void main() {
  late RecordingPromptPlayer player;
  late InMemoryEventLog log;
  late ActivitySession session;

  const items = [
    ActivityItem(id: '0', target: 'up', promptId: 'spatial.up_down.up', options: ['up', 'down']),
    ActivityItem(
      id: '1',
      target: 'down',
      promptId: 'spatial.up_down.down',
      options: ['up', 'down'],
    ),
  ];

  setUp(() {
    player = RecordingPromptPlayer();
    log = InMemoryEventLog();
    session = ActivitySession(
      stepId: 'up-down',
      activityId: 'spatial.up_down',
      items: items,
      prompts: testPrompts,
      player: player,
      log: log,
    );
  });

  test('starts with the intro and then presents the first item', () {
    session.start();
    expect(session.phase, SessionPhase.intro);

    session.begin();
    expect(session.phase, SessionPhase.playing);
    expect(player.spoken, ['intro', 'say up']);
  });

  test('ignores answers before the child starts playing', () {
    session.answer('up');
    expect(log.events, isEmpty);
  });

  test('a correct answer celebrates and next() moves to the following item', () {
    session.begin();
    session.answer('up');
    expect(session.phase, SessionPhase.celebrating);

    session.next();
    expect(session.phase, SessionPhase.playing);
    expect(session.currentItem.id, '1');
  });

  test('a wrong answer asks to retry and repeats the prompt', () {
    session.begin();
    session.answer('down');
    expect(session.isHintActive, isFalse);
    expect(player.spoken.last, 'retry say up');
  });

  test('feedback and the repeated prompt keep their recorded clips', () {
    session.begin();
    session.answer('down');

    expect(player.utterances.last.lines.map((line) => line.clip), [
      testClips['feedback.retry.0'],
      testClips['spatial.up_down.up.0'],
    ]);
  });

  test('the hint turns on after two mistakes and repeats the prompt', () {
    session.begin();
    session.answer('down');
    session.answer('down');
    expect(session.isHintActive, isTrue);
    expect(player.spoken.last, 'hint say up');
  });

  test('finishing the last item gives the reward', () {
    session.begin();
    session.answer('up');
    session.next();
    session.answer('down');
    session.next();

    expect(session.phase, SessionPhase.finished);
    expect(player.spoken.last, 'reward');
  });

  test('the demonstration shows on the first item and comes back as a hint', () {
    session.start();
    expect(session.showsDemo, isFalse);

    session.begin();
    expect(session.showsDemo, isTrue);

    session.answer('down');
    expect(session.showsDemo, isFalse);
    session.answer('down');
    expect(session.showsDemo, isTrue);

    session.answer('up');
    session.next();
    expect(session.currentItem.id, '1');
    expect(session.showsDemo, isFalse);
  });

  test('records every answer with its attempt number', () {
    session.begin();
    session.answer('down');
    session.answer('up');

    expect(log.events.map((e) => e.isCorrect), [false, true]);
    expect(log.events.map((e) => e.attempt), [1, 2]);
    expect(log.events.first.stepId, 'up-down');
  });
}
