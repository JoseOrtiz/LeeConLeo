import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/letters/stroke_tracer.dart';
import 'package:lee_con_leo/activities/letters/trace_path.dart';
import 'package:lee_con_leo/activities/letters/trace_view.dart';
import 'package:lee_con_leo/core/content/asset_content_repository.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/core/content/models/letter_shape.dart';

void main() {
  final bundle = ContentBundle.fromJson(
    jsonDecode(File(AssetContentRepository.bundlePath).readAsStringSync()) as Map<String, dynamic>,
  );

  for (final MapEntry(key: grapheme, value: shape) in bundle.letters.entries) {
    for (final letterCase in LetterCase.values) {
      test('${letterCase.apply(grapheme)} can be traced by following its strokes', () {
        final path = TracePath.fit(shape.strokes(letterCase), width: 400, height: 400);
        final tracer = StrokeTracer(
          strokes: path.strokes,
          tolerance: path.strokeWidth * TraceView.toleranceShare,
        );
        for (final (index, stroke) in path.strokes.indexed) {
          tracer.start(stroke.first);
          for (final point in stroke) {
            tracer.move(point);
          }
          tracer.end();
          expect(tracer.currentStroke, index + 1);
        }
        expect(tracer.isComplete, isTrue);
      });
    }
  }
}
