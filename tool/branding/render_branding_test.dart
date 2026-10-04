import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/common/widgets/letter_bubble.dart';
import 'package:lee_con_leo/app/app_theme.dart';
import 'package:lee_con_leo/app/widgets/loading_view.dart';

const outDir = 'assets/branding';
const iconBackground = Color(0xFF8FD3F4);

void main() {
  setUpAll(() async {
    final font = FontLoader(AppTheme.letterFont)
      ..addFont(rootBundle.load('assets/fonts/PlaywriteCL.ttf'));
    await font.load();
  });

  testWidgets('render the app icon and splash images', (tester) async {
    Directory(outDir).createSync(recursive: true);
    await _render(
      tester,
      const _Icon(background: iconBackground, safeArea: 0.86),
      1024,
      '$outDir/icon.png',
    );
    await _render(tester, const _Icon(safeArea: 0.61), 1024, '$outDir/icon_foreground.png');
    await _render(tester, const _Icon(safeArea: 0.54), 1152, '$outDir/splash_android12.png');
    await _render(tester, const LoadingView(animate: false), 1200, '$outDir/splash.png');
  });
}

class _Icon extends StatelessWidget {
  const _Icon({this.background, this.safeArea = 1});

  static const svgSize = Size(400, 560);
  static const bust = Rect.fromLTRB(50, 45, 350, 560);
  static const bustWidth = 0.78;
  static const bustTop = 0.2;
  static const letters = [
    ('a', Offset(0.1, 0.16), 0.48),
    ('e', Offset(0.92, 0.2), 0.42),
    ('o', Offset(0.04, 0.68), 0.34),
    ('u', Offset(0.97, 0.7), 0.32),
  ];

  final Color? background;
  final double safeArea;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final canvas = constraints.biggest.shortestSide;
        final safe = canvas * safeArea;
        final origin = (canvas - safe) / 2;
        final scale = safe * bustWidth / bust.width;
        return ColoredBox(
          color: background ?? Colors.transparent,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              for (final (letter, center, size) in letters)
                Positioned(
                  left: origin + safe * (center.dx - size / 2),
                  top: origin + safe * (center.dy - size / 2),
                  width: safe * size,
                  height: safe * size,
                  child: LetterBubble(letter: letter, letterShare: 0.95),
                ),
              Positioned(
                left: origin + (safe - bust.width * scale) / 2 - bust.left * scale,
                top: origin + safe * bustTop - bust.top * scale,
                width: svgSize.width * scale,
                height: svgSize.height * scale,
                child: SvgPicture.asset('assets/images/leo/leo_front.svg'),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _render(WidgetTester tester, Widget art, double size, String path) async {
  tester.view.physicalSize = Size.square(size);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final key = GlobalKey();
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Material(
        type: MaterialType.transparency,
        child: RepaintBoundary(key: key, child: art),
      ),
    ),
  );
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
  await tester.pump();
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(key));
  final bytes = await tester.runAsync(() async {
    final image = await boundary.toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  });
  File(path).writeAsBytesSync(bytes!);
}
