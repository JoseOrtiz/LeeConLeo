import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/spatial/positions_scene.dart';

void main() {
  const screens = {'phone': Size(390, 700), 'tablet': Size(1024, 700)};

  for (final MapEntry(key: name, value: size) in screens.entries) {
    group(name, () {
      final scene = PositionsScene.fit(size);
      final bounds = Offset.zero & size;

      test('drop zones never overlap', () {
        for (final a in scene.zones) {
          for (final b in scene.zones) {
            if (a == b) continue;
            expect(a.area.overlaps(b.area), isFalse, reason: '${a.id} overlaps ${b.id}');
          }
        }
      });

      test('everything stays on screen', () {
        for (final rect in [...scene.tables, scene.leoArea, scene.ballInTray, scene.floor]) {
          expect(bounds.expandToInclude(rect), bounds);
        }
      });

      test('the ball fits where it rests', () {
        for (final zone in scene.zones.where((zone) => zone.position != PositionsScene.over)) {
          final ball = scene.ballAt(zone.restingPlace);
          expect(zone.area.expandToInclude(ball), zone.area, reason: zone.id);
        }
      });

      test('the ball waiting in the tray is big enough to grab', () {
        expect(scene.trayBallSize, greaterThanOrEqualTo(PositionsScene.minTrayBall));
        expect(scene.ballInTray.overlaps(scene.leoArea), isFalse);
      });

      test('every position has a place to drop the ball', () {
        expect(scene.zones.map((zone) => zone.position).toSet(), {
          PositionsScene.over,
          PositionsScene.under,
          PositionsScene.between,
        });
      });
    });
  }
}
