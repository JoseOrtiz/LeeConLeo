import 'dart:math';

List<Point<double>> smoothPolyline(List<Point<double>> points, {int steps = 8}) {
  if (points.length < 3) return List.of(points);
  final isClosed = points.first == points.last;
  final last = points.length - 1;

  Point<double> at(int index) {
    if (index < 0) return isClosed ? points[last - 1] : points.first;
    if (index > last) return isClosed ? points[1] : points.last;
    return points[index];
  }

  return [
    points.first,
    for (var i = 0; i < last; i++)
      for (var s = 1; s <= steps; s++)
        _catmullRom(at(i - 1), at(i), at(i + 1), at(i + 2), s / steps),
  ];
}

Point<double> _catmullRom(
  Point<double> p0,
  Point<double> p1,
  Point<double> p2,
  Point<double> p3,
  double t,
) {
  final t2 = t * t;
  final t3 = t2 * t;
  double blend(double a, double b, double c, double d) =>
      0.5 * (2 * b + (c - a) * t + (2 * a - 5 * b + 4 * c - d) * t2 + (3 * b - a - 3 * c + d) * t3);
  return Point(blend(p0.x, p1.x, p2.x, p3.x), blend(p0.y, p1.y, p2.y, p3.y));
}
