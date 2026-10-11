import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/logging/drift_event_log.dart';
import 'package:lee_con_leo/core/logging/event_database.dart';

import '../../fakes/item_events.dart';

void main() {
  test('answers are saved and come back when the log opens again', () async {
    final database = EventDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final events = firstTries('a', correct: 2, wrong: 1);

    final log = await DriftEventLog.open(database);
    events.forEach(log.record);
    expect(log.events, hasLength(3));

    final reopened = await DriftEventLog.open(database);
    final saved = reopened.events;
    expect(saved, hasLength(3));
    for (final (index, event) in events.indexed) {
      expect(saved[index].sessionId, event.sessionId);
      expect(saved[index].timestamp, event.timestamp);
      expect(saved[index].answer, event.answer);
      expect(saved[index].responseTime, event.responseTime);
      expect(saved[index].isCorrect, event.isCorrect);
    }
  });
}
