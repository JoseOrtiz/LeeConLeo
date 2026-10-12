import 'activity_ids.dart';
import 'sound_position.dart';

enum PictureSoundGame {
  startsWith(ActivityIds.startsWith, SoundPosition.start, showsSound: true),
  endsWith(ActivityIds.endsWith, SoundPosition.end, showsSound: true),
  sameSound(ActivityIds.sameSound, SoundPosition.start, showsSound: false);

  const PictureSoundGame(this.activityId, this.position, {required this.showsSound});

  final String activityId;
  final SoundPosition position;
  final bool showsSound;
}
