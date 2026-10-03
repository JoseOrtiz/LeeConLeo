import 'dart:math';

import '../../core/content/models/letter_shape.dart';
import '../../utils/geometry/resample_polyline.dart';
import '../../utils/geometry/smooth_polyline.dart';

class TracePath {
  const TracePath._({required this.strokes, required this.strokeWidth});

  factory TracePath.fit(List<Stroke> shape, {required double width, required double height}) {
    final strokeWidth = min(width, height) * strokeShare;
    final points = shape.expand((stroke) => stroke);
    final left = points.map((p) => p.x).reduce(min);
    final right = points.map((p) => p.x).reduce(max);
    final top = points.map((p) => p.y).reduce(min);
    final bottom = points.map((p) => p.y).reduce(max);
    final margin = strokeWidth * marginShare;
    final scale = min(
      (width - 2 * margin) / max(right - left, 1),
      (height - 2 * margin) / max(bottom - top, 1),
    );
    final offset = Point(
      (width - (right - left) * scale) / 2 - left * scale,
      (height - (bottom - top) * scale) / 2 - top * scale,
    );
    return TracePath._(
      strokeWidth: strokeWidth,
      strokes: [
        for (final stroke in shape)
          resamplePolyline(
            smoothPolyline([for (final p in stroke) offset + p * scale]),
            strokeWidth * spacingShare,
          ),
      ],
    );
  }

  static const strokeShare = 0.09;
  static const marginShare = 1.5;
  static const spacingShare = 0.25;

  final List<Stroke> strokes;
  final double strokeWidth;

  double get spacing => strokeWidth * spacingShare;
}
