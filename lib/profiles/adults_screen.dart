import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/app_theme.dart';
import 'parental_gate.dart';
import 'profile_manager.dart';

class AdultsScreen extends StatefulWidget {
  const AdultsScreen({super.key});

  static const backKey = ValueKey('adults-back');

  @override
  State<AdultsScreen> createState() => _AdultsScreenState();
}

class _AdultsScreenState extends State<AdultsScreen> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        backgroundColor: AppTheme.cream,
        leading: IconButton(
          key: AdultsScreen.backKey,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: _isOpen
            ? const ProfileManager()
            : ParentalGate(onPassed: () => setState(() => _isOpen = true)),
      ),
    );
  }
}
