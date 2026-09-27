import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_registry.dart';
import 'spatial/up_down_activity.dart';

final activityRegistryProvider = Provider<ActivityRegistry>(
  (ref) => ActivityRegistry([const UpDownActivity()]),
);
