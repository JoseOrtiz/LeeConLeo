import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/logging/item_event.dart';
import 'package:lee_con_leo/core/progress/mastery.dart';

import '../../fakes/item_events.dart';

void main() {
  test('8 of the last 10 first tries right, over two sessions, masters a step', () {
    expect(Mastery.isMastered(firstTries('a', correct: 8, wrong: 2)), isTrue);
  });

  test('fewer than 8 right, fewer than 10 tries or a single session is not enough', () {
    expect(Mastery.isMastered(firstTries('a', correct: 7, wrong: 3)), isFalse);
    expect(Mastery.isMastered(firstTries('a', correct: 9)), isFalse);
    expect(Mastery.isMastered(firstTries('a', correct: 10, sessions: ['s1'])), isFalse);
  });

  test('only the last 10 first tries count, so early mistakes fade', () {
    expect(Mastery.isMastered(firstTries('a', correct: 10, wrong: 6)), isTrue);
  });

  test('retries after a mistake are not counted as tries', () {
    final events = firstTries('a', correct: 8, wrong: 2);
    final retries = [
      for (final event in events.where((event) => !event.isCorrect))
        ItemEvent(
          timestamp: event.timestamp.add(const Duration(seconds: 5)),
          sessionId: event.sessionId,
          stepId: event.stepId,
          activityId: event.activityId,
          itemId: event.itemId,
          target: event.target,
          answer: event.target,
          responseTime: event.responseTime,
          attempt: 2,
          hintUsed: false,
        ),
    ];
    expect(Mastery.isMastered([...events, ...retries]), isTrue);
    expect(Mastery.isMastered(firstTries('a', correct: 7, wrong: 3) + retries), isFalse);
  });

  test('mastered steps are found among the answers of every step', () {
    final events = [...firstTries('a', correct: 10), ...firstTries('e', correct: 4)];
    expect(Mastery.masteredSteps(events), {'a'});
  });
}
