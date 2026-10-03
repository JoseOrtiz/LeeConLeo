import 'dart:math';

List<Point<double>> resamplePolyline(List<Point<double>> points, double spacing) {
  if (points.length < 2) return List.of(points);
  final result = [points.first];
  var carried = 0.0;
  for (var i = 1; i < points.length; i++) {
    final from = points[i - 1];
    final to = points[i];
    final length = from.distanceTo(to);
    var along = spacing - carried;
    while (along <= length) {
      result.add(from + (to - from) * (along / length));
      along += spacing;
    }
    carried = length - (along - spacing);
  }
  if (result.last.distanceTo(points.last) > spacing / 2) {
    result.add(points.last);
  } else {
    result[result.length - 1] = points.last;
  }
  return result;
}
