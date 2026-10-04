import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/audio/audio_providers.dart';
import 'package:lee_con_leo/core/content/asset_content_repository.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';
import 'package:lee_con_leo/map/home_screen.dart';
import 'package:lee_con_leo/map/route_painter.dart';

import '../fakes/recording_prompt_player.dart';

void main() {
  final bundle = ContentBundle.fromJson(
    jsonDecode(File(AssetContentRepository.bundlePath).readAsStringSync()) as Map<String, dynamic>,
  );

  for (final (name, size) in [('phone', Size(360, 780)), ('tablet', Size(800, 1100))]) {
    testWidgets('no stage label covers the road on a $name', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [promptPlayerProvider.overrideWithValue(RecordingPromptPlayer())],
          child: MaterialApp(
            home: Scaffold(body: PathMap(bundle: bundle)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final painter = tester
          .widgetList<CustomPaint>(find.byType(CustomPaint))
          .map((paint) => paint.painter)
          .whereType<RoutePainter>()
          .single;
      final routeBox = tester.getRect(
        find.byWidgetPredicate((widget) => widget is CustomPaint && widget.painter == painter),
      );
      final road = RoutePainter.through([
        for (final point in painter.points) point + routeBox.topLeft,
      ]);

      for (final stage in bundle.stages) {
        final label = tester
            .getRect(find.byKey(ValueKey('stage-label-${stage.name}')))
            .inflate(RoutePainter.halfWidth);
        for (final metric in road.computeMetrics()) {
          for (var distance = 0.0; distance <= metric.length; distance += 2) {
            final point = metric.getTangentForOffset(distance)!.position;
            expect(label.contains(point), isFalse, reason: '${stage.name} covers $point');
          }
        }
      }
    });
  }
}
