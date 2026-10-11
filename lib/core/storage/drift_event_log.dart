import 'package:drift/drift.dart';

import '../logging/event_log.dart';
import '../logging/item_event.dart';
import 'app_database.dart';

class DriftEventLog implements EventLog {
  DriftEventLog._(this._database, this._profileId, this._events);

  static Future<DriftEventLog> open(AppDatabase database, int profileId) async {
    final rows =
        await (database.select(database.itemEvents)
              ..where((row) => row.profileId.equals(profileId))
              ..orderBy([(row) => OrderingTerm.asc(row.id)]))
            .get();
    return DriftEventLog._(database, profileId, [for (final row in rows) _fromRow(row)]);
  }

  final AppDatabase _database;
  final int _profileId;
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

  ItemEventsCompanion _toRow(ItemEvent event) => ItemEventsCompanion.insert(
    profileId: Value(_profileId),
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
