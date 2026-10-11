import 'package:drift/drift.dart';

import 'event_database.dart';
import 'event_log.dart';
import 'item_event.dart';

class DriftEventLog implements EventLog {
  DriftEventLog._(this._database, this._events);

  static Future<DriftEventLog> open(EventDatabase database) async {
    final rows = await (database.select(
      database.itemEvents,
    )..orderBy([(row) => OrderingTerm.asc(row.id)])).get();
    return DriftEventLog._(database, [for (final row in rows) _fromRow(row)]);
  }

  final EventDatabase _database;
  final List<ItemEvent> _events;

  @override
  List<ItemEvent> get events => List.unmodifiable(_events);

  @override
  void record(ItemEvent event) {
    _events.add(event);
    _database.into(_database.itemEvents).insert(_toRow(event));
  }

  static ItemEvent _fromRow(ItemEventRow row) => ItemEvent(
    timestamp: row.timestamp,
    sessionId: row.sessionId,
    stepId: row.stepId,
    activityId: row.activityId,
    itemId: row.itemId,
    target: row.target,
    answer: row.answer,
    responseTime: Duration(milliseconds: row.responseMillis),
    attempt: row.attempt,
    hintUsed: row.hintUsed,
  );

  static ItemEventsCompanion _toRow(ItemEvent event) => ItemEventsCompanion.insert(
    timestamp: event.timestamp,
    sessionId: event.sessionId,
    stepId: event.stepId,
    activityId: event.activityId,
    itemId: event.itemId,
    target: event.target,
    answer: event.answer,
    responseMillis: event.responseTime.inMilliseconds,
    attempt: event.attempt,
    hintUsed: event.hintUsed,
  );
}
