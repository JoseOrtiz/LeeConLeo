import 'dart:math';

typedef Stroke = List<Point<double>>;

enum LetterCase {
  lower,
  upper;

  String apply(String grapheme) => this == lower ? grapheme.toLowerCase() : grapheme.toUpperCase();
}

class LetterShape {
  const LetterShape({required this.lower, required this.upper});

  factory LetterShape.fromJson(Map<String, dynamic> json) =>
      LetterShape(lower: _strokes(json['lower']), upper: _strokes(json['upper']));

  final List<Stroke> lower;
  final List<Stroke> upper;

  List<Stroke> strokes(LetterCase letterCase) => letterCase == LetterCase.lower ? lower : upper;

  Map<String, dynamic> toJson() => {'lower': _encode(lower), 'upper': _encode(upper)};

  static List<Stroke> _strokes(Object? json) => [
    for (final stroke in json as List? ?? const [])
      [
        for (final point in stroke as List)
          Point(((point as List)[0] as num).toDouble(), (point[1] as num).toDouble()),
      ],
  ];

  static List<List<List<num>>> _encode(List<Stroke> strokes) => [
    for (final stroke in strokes)
      [
        for (final point in stroke) [_compact(point.x), _compact(point.y)],
      ],
  ];

  static num _compact(double value) => value == value.roundToDouble() ? value.round() : value;
}
