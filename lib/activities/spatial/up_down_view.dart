import 'package:flutter/material.dart';

import '../../app/widgets/leo_avatar.dart';
import '../common/activity_item.dart';
import '../common/item_controller.dart';
import '../common/widgets/choice_button.dart';
import 'up_down_activity.dart';

class UpDownView extends StatelessWidget {
  const UpDownView({super.key, required this.item, required this.controller});

  final ActivityItem item;
  final ItemController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _arrow(UpDownActivity.up, Icons.arrow_upward_rounded)),
        const Padding(padding: EdgeInsets.all(16), child: LeoAvatar(size: 96)),
        Expanded(child: _arrow(UpDownActivity.down, Icons.arrow_downward_rounded)),
      ],
    );
  }

  Widget _arrow(String value, IconData icon) => ChoiceButton(
    key: ValueKey('choice-$value'),
    icon: icon,
    isHighlighted: controller.isHintActive && item.target == value,
    onPressed: () => controller.answer(value),
  );
}
