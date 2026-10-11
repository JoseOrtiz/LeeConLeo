import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/storage/app_database.dart';
import 'package:lee_con_leo/core/storage/drift_profile_store.dart';

import '../../fakes/item_events.dart';

void main() {
  group('store', () {
    late AppDatabase database;
    late DriftProfileStore store;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      store = DriftProfileStore(database);
    });
    tearDown(() => database.close());

    test('profiles keep their own finished steps and answers', () async {
      final ana = await store.create(nickname: 'Ana', avatar: 'words/oso.svg');
      final beto = await store.create(nickname: 'Beto', avatar: 'words/pato.svg');

      final anaData = await store.open(ana);
      await anaData.progress.markCompleted('a');
      firstTries('a', correct: 2).forEach(anaData.events.record);

      expect((await store.all()).map((profile) => profile.nickname), ['Ana', 'Beto']);
      final reopened = await store.open(ana);
      expect(reopened.progress.completedSteps, {'a'});
      expect(reopened.events.events, hasLength(2));
      final other = await store.open(beto);
      expect(other.progress.completedSteps, isEmpty);
      expect(other.events.events, isEmpty);
    });

    test('deleting a profile deletes its progress too', () async {
      final ana = await store.create(nickname: 'Ana', avatar: 'words/oso.svg');
      final data = await store.open(ana);
      await data.progress.markCompleted('a');
      firstTries('a', correct: 1).forEach(data.events.record);

      await store.delete(ana);

      expect(await store.all(), isEmpty);
      expect(await database.select(database.completedSteps).get(), isEmpty);
      expect(await database.select(database.itemEvents).get(), isEmpty);
    });
  });

  test('a database from before profiles keeps its answers after the upgrade', () async {
    final old = AppDatabase(
      NativeDatabase.memory(
        setup: (raw) {
          raw.execute('''
            CREATE TABLE item_events (
              id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp INTEGER NOT NULL,
              session_id TEXT NOT NULL, step_id TEXT NOT NULL, activity_id TEXT NOT NULL,
              item_id TEXT NOT NULL, target TEXT NOT NULL, answer TEXT NOT NULL,
              response_millis INTEGER NOT NULL, attempt INTEGER NOT NULL,
              hint_used INTEGER NOT NULL CHECK (hint_used IN (0, 1)))''');
          raw.execute(
            "INSERT INTO item_events VALUES (1, 0, 's1', 'a', 'letter.meet', '0', 'a', 'a', 900, 1, 0)",
          );
          raw.execute('PRAGMA user_version = 1');
        },
      ),
    );
    addTearDown(old.close);

    final rows = await old.select(old.itemEvents).get();
    expect(rows.single.profileId, 0);
    expect(await DriftProfileStore(old).all(), isEmpty);
  });
}
