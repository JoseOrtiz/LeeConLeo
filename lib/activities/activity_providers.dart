import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_registry.dart';
import 'letters/find_activity.dart';
import 'letters/meet_activity.dart';
import 'letters/trace_activity.dart';
import 'sounds/picture_sound_activity.dart';
import 'spatial/direction_activity.dart';
import 'spatial/positions_activity.dart';
import 'syllables/syllable_find_activity.dart';
import 'syllables/syllable_meet_activity.dart';
import 'syllables/syllable_trace_activity.dart';

final activityRegistryProvider = Provider<ActivityRegistry>(
  (ref) => ActivityRegistry([
    DirectionActivity.upDown,
    DirectionActivity.leftRight,
    const PositionsActivity(),
    const MeetActivity(),
    const TraceActivity(),
    const FindActivity(),
    const SyllableMeetActivity(),
    const SyllableTraceActivity(),
    const SyllableFindActivity(),
    PictureSoundActivity.startsWith,
    PictureSoundActivity.endsWith,
  ]),
);
