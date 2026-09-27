import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../app/widgets/leo_avatar.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            key: const ValueKey('reward'),
            size: 200,
            color: AppTheme.starGold,
          ),
          const LeoAvatar(size: 200, pose: LeoPose.cheering),
          const SizedBox(height: 32),
          IconButton.filled(
            key: const ValueKey('done'),
            iconSize: 72,
            onPressed: onDone,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
    );
  }
}
