import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DataClassName('ProfileRow')
class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nickname => text()();
  TextColumn get avatar => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('CompletedStepRow')
class CompletedSteps extends Table {
  IntColumn get profileId => integer()();
  TextColumn get stepId => text()();
  DateTimeColumn get completedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId, stepId};
}

@DataClassName('PlayedGameRow')
class PlayedGames extends Table {
  IntColumn get profileId => integer()();
  TextColumn get stepId => text()();
  TextColumn get activityId => text()();
  DateTimeColumn get playedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId, stepId, activityId};
}

@DataClassName('ItemEventRow')
class ItemEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().withDefault(const Constant(0))();
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

@DriftDatabase(tables: [Profiles, CompletedSteps, PlayedGames, ItemEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(profiles);
        await migrator.createTable(completedSteps);
        await migrator.addColumn(itemEvents, itemEvents.profileId);
      }
      if (from < 3) await migrator.createTable(playedGames);
    },
  );
}
