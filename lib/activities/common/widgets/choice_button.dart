import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isHighlighted = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: isHighlighted ? colors.tertiary : Colors.transparent, width: 8),
        ),
        child: Material(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onPressed,
            child: Center(
              child: FittedBox(child: Icon(icon, size: 160, color: colors.onPrimaryContainer)),
            ),
          ),
        ),
      ),
    );
  }
}
