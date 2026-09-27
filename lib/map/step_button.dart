import 'package:flutter/material.dart';

import '../core/content/models/path_step.dart';

class StepButton extends StatelessWidget {
  const StepButton({super.key, required this.step, this.onPressed});

  final PathStep step;
  final VoidCallback? onPressed;

  static const size = 96.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;
    final foreground = isEnabled ? colors.onPrimary : colors.onSurfaceVariant;
    final grapheme = step.grapheme;

    return SizedBox.square(
      dimension: size,
      child: Material(
        shape: const CircleBorder(),
        color: isEnabled ? colors.primary : colors.surfaceContainerHighest,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(
            child: grapheme == null
                ? Icon(Icons.explore_rounded, size: 48, color: foreground)
                : Text(grapheme, style: TextStyle(fontSize: 48, color: foreground)),
          ),
        ),
      ),
    );
  }
}
