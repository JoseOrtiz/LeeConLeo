import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/letters/stroke_tracer.dart';

void main() {
  final line = [for (var y = 0; y <= 100; y += 5) Point(0.0, y.toDouble())];
  final loop = [
    for (var degrees = 90; degrees <= 450; degrees += 10)
      Point(50 * cos(degrees * pi / 180), -50 * sin(degrees * pi / 180)),
  ];

  StrokeTracer tracer(List<List<Point<double>>> strokes) =>
      StrokeTracer(strokes: strokes, tolerance: 8);

  void follow(StrokeTracer tracer, List<Point<double>> stroke) {
    tracer.start(stroke.first);
    for (final point in stroke.skip(1)) {
      tracer.move(point + const Point(3.0, 0.0));
    }
    tracer.end();
  }

  test('following the strokes in order completes the letter', () {
    final letter = tracer([line, loop]);

    follow(letter, line);
    expect(letter.currentStroke, 1);
    follow(letter, loop);

    expect(letter.isComplete, isTrue);
  });

  test('a stroke must start at its start point', () {
    final letter = tracer([line]);

    letter.start(line.last);
    for (final point in line.reversed) {
      letter.move(point);
    }

    expect(letter.reached, 0);
    expect(letter.isComplete, isFalse);
  });

  test('a closed loop cannot be finished by staying at the start', () {
    final letter = tracer([loop]);

    letter.start(loop.first);
    letter.move(loop.last);

    expect(letter.isComplete, isFalse);
  });

  test('wandering away stops the trace until the finger comes back to the tip', () {
    final letter = tracer([line]);
    letter.start(line.first);
    letter.move(line[2]);
    final reached = letter.reached;
    letter.move(const Point(60.0, 50.0));
    letter.move(line[reached + 2]);
    expect(letter.reached, reached);

    letter.start(line[reached]);
    letter.move(line[reached + 2]);
    expect(letter.reached, greaterThan(reached));
  });

  test('a short bar traced out and back cannot be skipped at its start', () {
    const bar = [
      Point(0.0, 0.0),
      Point(5.0, 0.0),
      Point(10.0, 0.0),
      Point(5.0, 3.0),
      Point(0.0, 3.0),
    ];
    final letter = tracer([bar]);

    letter.start(bar.first);
    letter.move(bar.first);
    expect(letter.isComplete, isFalse);

    for (final point in bar) {
      letter.move(point);
    }
    expect(letter.isComplete, isTrue);
  });

  test('a dot is traced with a single touch', () {
    final letter = tracer([
      [const Point(0.0, -40.0)],
    ]);

    letter.start(const Point(4.0, -38.0));

    expect(letter.isComplete, isTrue);
  });
}
