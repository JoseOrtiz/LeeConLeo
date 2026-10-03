import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class LetterGlyph extends StatelessWidget {
  const LetterGlyph(this.text, {super.key, this.size = 160, this.color});

  final String text;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    text,
    textScaler: TextScaler.noScaling,
    style: TextStyle(fontFamily: AppTheme.letterFont, fontSize: size, height: 1.1, color: color),
  );
}
