import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/map/label_slot.dart';

void main() {
  Path verticalRoad(double x) => Path()
    ..moveTo(x, 0)
    ..lineTo(x, 300);

  LabelSlot slotFor(Path road) =>
      labelSlot(road: road, roadHalfWidth: 20, top: 100, bottom: 140, width: 400);

  test('the label goes to the side the road leaves free', () {
    final roadOnLeft = slotFor(verticalRoad(100));
    expect(roadOnLeft.isLeft, isFalse);
    expect(roadOnLeft.maxWidth, 400 - 100 - 20 - 32);

    expect(slotFor(verticalRoad(300)).isLeft, isTrue);
  });

  test('a road away from the label leaves the whole width', () {
    final road = Path()
      ..moveTo(200, 200)
      ..lineTo(200, 300);
    expect(slotFor(road).isLeft, isTrue);
    expect(slotFor(road).maxWidth, 400 - 32);
  });
}
