import 'dart:math';

import '../../core/content/models/letter_shape.dart';

class StrokeTracer {
  StrokeTracer({required this.strokes, required this.tolerance});

  static const lostFactor = 2.0;

  final List<Stroke> strokes;
  final double tolerance;

  int _stroke = 0;
  int _reached = 0;
  bool _isTracing = false;

  int get currentStroke => _stroke;

  int get reached => _reached;

  bool get isComplete => _stroke >= strokes.length;

  Point<double>? get tip => isComplete ? null : strokes[_stroke][_reached];

  int reachedIn(int stroke) {
    if (stroke < _stroke) return strokes[stroke].length - 1;
    if (stroke == _stroke) return _reached;
    return -1;
  }

  void start(Point<double> finger) {
    final tip = this.tip;
    if (tip == null) return;
    _isTracing = finger.distanceTo(tip) <= tolerance;
    if (_isTracing) _finishStrokeIfDone();
  }

  void move(Point<double> finger) {
    if (!_isTracing || isComplete) return;
    final stroke = strokes[_stroke];
    final start = _reached;
    while (_reached < stroke.length - 1 && finger.distanceTo(stroke[_reached + 1]) <= tolerance) {
      _reached++;
    }
    if (_reached > start) {
      _finishStrokeIfDone();
    } else if (finger.distanceTo(stroke[_reached]) > tolerance * lostFactor) {
      _isTracing = false;
    }
  }

  void end() => _isTracing = false;

  void _finishStrokeIfDone() {
    if (_reached < strokes[_stroke].length - 1) return;
    _stroke++;
    _reached = 0;
    _isTracing = false;
  }
}
