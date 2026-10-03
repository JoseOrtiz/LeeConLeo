import 'package:flutter/material.dart';

import '../../app/widgets/leo_avatar.dart';
import '../common/activity_item.dart';
import '../common/item_controller.dart';
import '../common/widgets/choice_button.dart';
import '../common/widgets/leo_beside.dart';
import 'direction_activity.dart';

class DirectionView extends StatelessWidget {
  const DirectionView({
    super.key,
    required this.activity,
    required this.item,
    required this.controller,
  });

  static const leoHeight = 140.0;
  static const leoMargin = 16.0;
  static const moveDuration = Duration(milliseconds: 600);

  final DirectionActivity activity;
  final ActivityItem item;
  final ItemController controller;

  bool get _isVertical => activity.axis == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: [
          Flex(
            direction: activity.axis,
            children: [
              Expanded(child: _arrow(activity.first)),
              SizedBox.fromSize(size: _leoSpace),
              Expanded(child: _arrow(activity.second)),
            ],
          ),
          IgnorePointer(
            child: AnimatedAlign(
              alignment: controller.isSolved ? _arrowAlignment(constraints) : Alignment.center,
              duration: moveDuration,
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.all(leoMargin),
                child: LeoAvatar(size: leoHeight, pose: leoPoseFor(controller)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Alignment _arrowAlignment(BoxConstraints constraints) {
    final extent = _isVertical ? constraints.maxHeight : constraints.maxWidth;
    final leoExtent = _isVertical ? _leoSpace.height : _leoSpace.width;
    final offset = 0.5 + leoExtent / (extent - leoExtent);
    final signed = item.target == activity.first.value ? -offset : offset;
    return _isVertical ? Alignment(0, signed) : Alignment(signed, 0);
  }

  Size get _leoSpace {
    const height = leoHeight + 2 * leoMargin;
    const width = leoHeight * LeoAvatar.aspectRatio + 2 * leoMargin;
    return _isVertical ? const Size(0, height) : const Size(width, 0);
  }

  Widget _arrow(Direction direction) => ChoiceButton(
    key: ValueKey('choice-${direction.value}'),
    isHighlighted: controller.isHintActive && item.target == direction.value,
    onPressed: () => controller.answer(direction.value),
    child: Icon(direction.icon),
  );
}
