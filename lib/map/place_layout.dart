import 'dart:math';
import 'dart:ui';

import '../app/widgets/leo_avatar.dart';

class PlaceLayout {
  PlaceLayout._({
    required this.size,
    required this.stepCenters,
    required this.stoneSize,
    required this.entry,
    required this.exit,
  });

  factory PlaceLayout.fit({
    required Size size,
    required List<double> columns,
    double? enteringColumn,
    double? leavingColumn,
    double maxRouteWidth = double.infinity,
  }) {
    final width = min(size.width, maxRouteWidth);
    final inset = (size.width - width) / 2;
    final available = size.height - topSpace - bottomSpace;
    final row = min(maxRow, available / max(columns.length, 1));
    final stone = (row * stoneShare).clamp(minStone, maxStone);
    final firstY = size.height - bottomSpace - (available - row * columns.length) / 2 - row / 2;
    double xOf(double column) => inset + width * column;
    return PlaceLayout._(
      size: size,
      stoneSize: stone.toDouble(),
      stepCenters: [
        for (final (index, column) in columns.indexed) Offset(xOf(column), firstY - index * row),
      ],
      entry: enteringColumn == null ? null : Offset(xOf(enteringColumn), size.height),
      exit: leavingColumn == null ? null : Offset(xOf(leavingColumn), 0),
    );
  }

  static const topSpace = 72.0;
  static const bottomSpace = 32.0;
  static const maxRow = 150.0;
  static const stoneShare = 0.8;
  static const minStone = 64.0;
  static const maxStone = 96.0;
  static const leoShare = 112 / 96;
  static const leoGap = 8.0;

  final Size size;
  final List<Offset> stepCenters;
  final double stoneSize;
  final Offset? entry;
  final Offset? exit;

  double get leoHeight => stoneSize * leoShare;

  List<Offset> get road => [?entry, ...stepCenters, ?exit];

  Rect stoneAt(int index) =>
      Rect.fromCenter(center: stepCenters[index], width: stoneSize, height: stoneSize);

  Rect leoBeside(int index) => _leoAt(stoneAt(index));

  Rect get leoEntering {
    final from = Offset(entry?.dx ?? size.width / 2, size.height + leoHeight);
    return _leoAt(Rect.fromCenter(center: from, width: stoneSize, height: stoneSize));
  }

  Rect _leoAt(Rect stone) {
    final leoWidth = leoHeight * LeoAvatar.aspectRatio;
    final left = stone.center.dx >= size.width / 2
        ? stone.left - leoGap - leoWidth
        : stone.right + leoGap;
    return Rect.fromLTWH(left, stone.bottom - leoHeight, leoWidth, leoHeight);
  }
}
