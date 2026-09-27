import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'app_theme.dart';

class LeeConLeoApp extends StatefulWidget {
  const LeeConLeoApp({super.key});

  @override
  State<LeeConLeoApp> createState() => _LeeConLeoAppState();
}

class _LeeConLeoAppState extends State<LeeConLeoApp> {
  final GoRouter _router = createAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lee con Leo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _router,
    );
  }
}
