import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_registry.dart';
import 'letters/find_activity.dart';
import 'letters/meet_activity.dart';
import 'letters/trace_activity.dart';
import 'sounds/starts_with_activity.dart';
import 'spatial/direction_activity.dart';
import 'spatial/positions_activity.dart';

final activityRegistryProvider = Provider<ActivityRegistry>(
  (ref) => ActivityRegistry([
    DirectionActivity.upDown,
    DirectionActivity.leftRight,
    const PositionsActivity(),
    const MeetActivity(),
    const TraceActivity(),
    const FindActivity(),
    const StartsWithActivity(),
  ]),
);
