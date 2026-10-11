import 'package:drift/drift.dart';

part 'event_database.g.dart';

@DataClassName('ItemEventRow')
class ItemEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get sessionId => text()();
  TextColumn get stepId => text()();
  TextColumn get activityId => text()();
  TextColumn get itemId => text()();
  TextColumn get target => text()();
  TextColumn get answer => text()();
  IntColumn get responseMillis => integer()();
  IntColumn get attempt => integer()();
  BoolColumn get hintUsed => boolean()();
}

@DriftDatabase(tables: [ItemEvents])
class EventDatabase extends _$EventDatabase {
  EventDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
