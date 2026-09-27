import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_registry.dart';
import 'spatial/direction_activity.dart';

final activityRegistryProvider = Provider<ActivityRegistry>(
  (ref) => ActivityRegistry([DirectionActivity.upDown, DirectionActivity.leftRight]),
);
