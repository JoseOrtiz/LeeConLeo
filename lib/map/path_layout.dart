import 'dart:ui';

import '../app/widgets/leo_avatar.dart';
import '../core/content/models/path_stage.dart';

class PathLayout {
  PathLayout._({
    required this.width,
    required this.height,
    required this.stageBands,
    required this.stepCenters,
  });

  factory PathLayout.fit({
    required double width,
    required List<PathStage> stages,
    double minHeight = 0,
  }) {
    final bandsFromBottom = <(double, double)>[];
    final centersFromBottom = <String, Offset>{};
    var index = 0;
    var fromBottom = 0.0;
    for (final stage in stages) {
      final bandStart = fromBottom;
      fromBottom += stagePadding;
      for (final step in stage.steps) {
        final x = width * zigzag[index++ % zigzag.length];
        centersFromBottom[step.id] = Offset(x, fromBottom + rowHeight / 2);
        fromBottom += rowHeight;
      }
      fromBottom += labelSpace;
      bandsFromBottom.add((bandStart, fromBottom));
    }
    if (fromBottom < minHeight && bandsFromBottom.isNotEmpty) {
      bandsFromBottom.last = (bandsFromBottom.last.$1, minHeight);
      fromBottom = minHeight;
    }
    final height = fromBottom;
    return PathLayout._(
      width: width,
      height: height,
      stageBands: [
        for (final (start, end) in bandsFromBottom)
          Rect.fromLTRB(0, height - end, width, height - start),
      ],
      stepCenters: {
        for (final MapEntry(key: id, value: center) in centersFromBottom.entries)
          id: Offset(center.dx, height - center.dy),
      },
    );
  }

  static const rowHeight = 150.0;
  static const stagePadding = 56.0;
  static const labelSpace = 72.0;
  static const stoneSize = 96.0;
  static const leoHeight = 112.0;
  static const leoGap = 8.0;
  static const zigzag = [0.5, 0.74, 0.5, 0.26];

  final double width;
  final double height;
  final List<Rect> stageBands;
  final Map<String, Offset> stepCenters;

  Rect stoneOf(String stepId) =>
      Rect.fromCenter(center: stepCenters[stepId]!, width: stoneSize, height: stoneSize);

  Rect leoBeside(String stepId) {
    final stone = stoneOf(stepId);
    const leoWidth = leoHeight * LeoAvatar.aspectRatio;
    final left = stone.center.dx >= width / 2
        ? stone.left - leoGap - leoWidth
        : stone.right + leoGap;
    return Rect.fromLTWH(left, stone.bottom - leoHeight, leoWidth, leoHeight);
  }
}
