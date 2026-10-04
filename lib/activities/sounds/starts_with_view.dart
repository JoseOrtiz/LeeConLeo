import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/item_controller.dart';
import '../common/widgets/choice_button.dart';
import '../common/widgets/demo_overlay.dart';
import '../common/widgets/leo_beside.dart';
import 'starts_with_activity.dart';

class StartsWithView extends StatelessWidget {
  const StartsWithView({super.key, required this.item, required this.controller});

  final PictureItem item;
  final ItemController controller;

  int _columns(Size size) => size.width > size.height * 1.5 ? item.options.length : 2;

  int _rows(Size size) => (item.options.length / _columns(size)).ceil();

  @override
  Widget build(BuildContext context) {
    return LeoBeside(
      controller: controller,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final columns = _columns(size);
          return DemoOverlay(
            key: ValueKey('demo-${item.id}'),
            show: controller.showsDemo,
            path: [_centerOf(item.options.indexOf(item.target), size)],
            child: Column(
              children: [
                for (var row = 0; row < _rows(size); row++)
                  Expanded(
                    child: Row(
                      children: [
                        for (final word in item.options.skip(row * columns).take(columns))
                          Expanded(child: _picture(word)),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Offset _centerOf(int index, Size size) {
    final columns = _columns(size);
    return Offset(
      (index % columns + 0.5) * size.width / columns,
      (index ~/ columns + 0.5) * size.height / _rows(size),
    );
  }

  Widget _picture(String word) => ChoiceButton(
    key: ValueKey('choice-$word'),
    isHighlighted: controller.isHintActive && word == item.target,
    onPressed: () => controller.answer(word),
    child: SvgPicture.asset('assets/images/${item.images[word]}'),
  );
}
