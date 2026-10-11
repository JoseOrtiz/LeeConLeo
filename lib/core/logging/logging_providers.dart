import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profiles/profile_providers.dart';
import 'event_log.dart';
import 'in_memory_event_log.dart';

final eventLogProvider = Provider<EventLog>(
  (ref) => ref.watch(activeProfileProvider)?.data.events ?? InMemoryEventLog(),
);

final sessionIdProvider = Provider<String>(
  (ref) => DateTime.now().toUtc().microsecondsSinceEpoch.toString(),
);
