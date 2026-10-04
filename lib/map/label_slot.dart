import 'dart:math';
import 'dart:ui';

class LabelSlot {
  const LabelSlot({required this.isLeft, required this.maxWidth});

  final bool isLeft;
  final double maxWidth;
}

LabelSlot labelSlot({
  required Path road,
  required double roadHalfWidth,
  required double top,
  required double bottom,
  required double width,
  double margin = 16,
  double step = 4,
}) {
  var nearest = double.infinity;
  var farthest = double.negativeInfinity;
  for (final metric in road.computeMetrics()) {
    for (var distance = 0.0; distance <= metric.length; distance += step) {
      final point = metric.getTangentForOffset(distance)!.position;
      if (point.dy < top - roadHalfWidth || point.dy > bottom + roadHalfWidth) continue;
      nearest = min(nearest, point.dx);
      farthest = max(farthest, point.dx);
    }
  }
  if (nearest == double.infinity) return LabelSlot(isLeft: true, maxWidth: width - 2 * margin);
  final left = nearest - roadHalfWidth - 2 * margin;
  final right = width - farthest - roadHalfWidth - 2 * margin;
  return left >= right
      ? LabelSlot(isLeft: true, maxWidth: max(0, left))
      : LabelSlot(isLeft: false, maxWidth: max(0, right));
}
