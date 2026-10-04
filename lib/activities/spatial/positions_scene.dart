import 'dart:math';
import 'dart:ui';

import '../../app/widgets/leo_avatar.dart';

class SceneZone {
  const SceneZone({
    required this.id,
    required this.position,
    required this.area,
    required this.restingPlace,
  });

  final String id;
  final String position;
  final Rect area;
  final Offset restingPlace;
}

class PositionsScene {
  PositionsScene._({
    required this.tables,
    required this.zones,
    required this.ballSize,
    required this.ballStart,
    required this.leoArea,
    required this.floor,
  });

  factory PositionsScene.fit(Size size) {
    final trayHeight = size.height * trayShare;
    final sceneHeight = size.height - trayHeight;
    final table = min(size.width * 0.95 / (2 + gapShare), sceneHeight / (1 + headroomShare));
    final gap = table * gapShare;
    final firstLeft = (size.width - 2 * table - gap) / 2;
    final lefts = [firstLeft, firstLeft + table + gap];
    final top = (sceneHeight - table * (1 + headroomShare)) / 2 + table * headroomShare;
    final surface = top + table * tableSurface;
    final floor = top + table * tableFloor;
    final ball = table * ballShare;
    final trayCenter = sceneHeight + trayHeight / 2;
    final leoHeight = trayHeight * 0.9;

    return PositionsScene._(
      tables: [for (final left in lefts) Rect.fromLTWH(left, top, table, table)],
      zones: [
        for (final (index, left) in lefts.indexed) ...[
          SceneZone(
            id: '$over-$index',
            position: over,
            area: Rect.fromLTRB(
              left + table * 0.1,
              top - table * headroomShare,
              left + table * 0.9,
              surface,
            ),
            restingPlace: Offset(left + table / 2, surface - ball / 2),
          ),
          SceneZone(
            id: '$under-$index',
            position: under,
            area: Rect.fromLTRB(
              left + table * tableLegsStart,
              top + table * tableUnderside,
              left + table * tableLegsEnd,
              floor,
            ),
            restingPlace: Offset(left + table / 2, floor - ball / 2),
          ),
        ],
        SceneZone(
          id: between,
          position: between,
          area: Rect.fromLTRB(lefts[0] + table * 0.9, surface, lefts[1] + table * 0.1, floor),
          restingPlace: Offset(lefts[0] + table + gap / 2, floor - ball / 2),
        ),
      ],
      ballSize: ball,
      ballStart: Offset(size.width * 0.64, trayCenter),
      floor: Rect.fromLTRB(0, floor, size.width, size.height),
      leoArea: Rect.fromCenter(
        center: Offset(size.width * 0.34, trayCenter),
        width: leoHeight * LeoAvatar.aspectRatio,
        height: leoHeight,
      ),
    );
  }

  static const over = 'over';
  static const under = 'under';
  static const between = 'between';
  static const trayShare = 0.3;
  static const gapShare = 0.5;
  static const headroomShare = 0.2;
  static const ballShare = 0.32;
  static const grabShare = 1.8;
  static const minTrayBall = 64.0;
  static const tableSurface = 0.34;
  static const tableUnderside = 0.49;
  static const tableFloor = 0.84;
  static const tableLegsStart = 0.245;
  static const tableLegsEnd = 0.755;

  final List<Rect> tables;
  final List<SceneZone> zones;
  final double ballSize;
  final Offset ballStart;
  final Rect leoArea;
  final Rect floor;

  double get trayBallSize => max(ballSize, minTrayBall);

  Rect ballAt(Offset center) => Rect.fromCenter(center: center, width: ballSize, height: ballSize);

  Rect get ballInTray =>
      Rect.fromCenter(center: ballStart, width: trayBallSize, height: trayBallSize);

  Rect get grabArea => Rect.fromCenter(
    center: ballStart,
    width: trayBallSize * grabShare,
    height: trayBallSize * grabShare,
  );
}
