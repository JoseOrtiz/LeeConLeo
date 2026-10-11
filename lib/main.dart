import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/lee_con_leo_app.dart';
import 'core/logging/drift_event_log.dart';
import 'core/logging/event_database.dart';
import 'core/logging/event_log.dart';
import 'core/logging/in_memory_event_log.dart';
import 'core/logging/logging_providers.dart';
import 'core/progress/device_progress_store.dart';
import 'core/progress/progress_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final progress = await DeviceProgressStore.open();
  final events = await _openEventLog();
  final container = ProviderContainer(
    overrides: [
      progressStoreProvider.overrideWithValue(progress),
      eventLogProvider.overrideWithValue(events),
    ],
  );
  runApp(UncontrolledProviderScope(container: container, child: const LeeConLeoApp()));
}

Future<EventLog> _openEventLog() async => kIsWeb
    ? InMemoryEventLog()
    : DriftEventLog.open(EventDatabase(driftDatabase(name: 'lee_con_leo')));
