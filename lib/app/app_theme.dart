import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFFFF9F1C);

  static ThemeData light() =>
      ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed), useMaterial3: true);
}
