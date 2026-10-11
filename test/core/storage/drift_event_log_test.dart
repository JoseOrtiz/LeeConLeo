import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/storage/app_database.dart';
import 'package:lee_con_leo/core/storage/drift_event_log.dart';

import '../../fakes/item_events.dart';

void main() {
  test('answers are saved per profile and come back when the log opens again', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final events = firstTries('a', correct: 2, wrong: 1);

    final log = await DriftEventLog.open(database, 1);
    events.forEach(log.record);
    (await DriftEventLog.open(database, 2)).record(firstTries('e', correct: 1).single);
    expect(log.events, hasLength(3));

    final saved = (await DriftEventLog.open(database, 1)).events;
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
