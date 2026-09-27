import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'event_log.dart';
import 'in_memory_event_log.dart';

final eventLogProvider = Provider<EventLog>((ref) => InMemoryEventLog());
