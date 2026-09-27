import 'package:flutter/material.dart';

class LeoAvatar extends StatelessWidget {
  const LeoAvatar({super.key, this.size = 160});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: colors.secondaryContainer, shape: BoxShape.circle),
      child: Icon(Icons.pets_rounded, size: size * 0.6, color: colors.onSecondaryContainer),
    );
  }
}
