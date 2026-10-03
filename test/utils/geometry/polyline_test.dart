import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/utils/geometry/resample_polyline.dart';
import 'package:lee_con_leo/utils/geometry/smooth_polyline.dart';

void main() {
  group('resamplePolyline', () {
    test('places points at even steps and keeps both ends', () {
      final points = resamplePolyline(const [Point(0.0, 0.0), Point(10.0, 0.0)], 2.5);
      expect(points.map((p) => p.x), [0, 2.5, 5, 7.5, 10]);
    });

    test('keeps the spacing across corners', () {
      final points = resamplePolyline(const [Point(0.0, 0.0), Point(3.0, 0.0), Point(3.0, 3.0)], 2);
      expect(points, hasLength(4));
      expect(points[1], const Point(2.0, 0.0));
      expect(points[2], const Point(3.0, 1.0));
      expect(points.last, const Point(3.0, 3.0));
    });

    test('a single point stays a single point', () {
      expect(resamplePolyline(const [Point(1.0, 1.0)], 2), [const Point(1.0, 1.0)]);
    });
  });

  group('smoothPolyline', () {
    test('passes through every control point', () {
      const control = [Point(0.0, 0.0), Point(10.0, 10.0), Point(20.0, 0.0)];
      final smooth = smoothPolyline(control, steps: 4);
      for (final point in control) {
        expect(smooth.any((p) => p.distanceTo(point) < 1e-9), isTrue);
      }
      expect(smooth, hasLength(9));
    });

    test('a two point stroke stays straight', () {
      const line = [Point(0.0, 0.0), Point(0.0, 10.0)];
      expect(smoothPolyline(line), line);
    });

    test('a closed loop has no corner where it starts', () {
      final circle = [
        for (var degrees = 90; degrees <= 450; degrees += 45)
          Point(
            (100 * cos(degrees * pi / 180)).roundToDouble(),
            (-100 * sin(degrees * pi / 180)).roundToDouble(),
          ),
      ];
      final smooth = smoothPolyline(circle, steps: 8);
      final leaving = smooth[1] - smooth[0];
      final arriving = smooth.last - smooth[smooth.length - 2];
      final cosine =
          (leaving.x * arriving.x + leaving.y * arriving.y) /
          (leaving.magnitude * arriving.magnitude);
      expect(acos(cosine) * 180 / pi, lessThan(10));
    });
  });
}
