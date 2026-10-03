import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/content/models/letter_shape.dart';
import '../common/item_controller.dart';
import '../common/widgets/choice_button.dart';
import '../common/widgets/leo_beside.dart';
import '../common/widgets/letter_glyph.dart';
import 'meet_activity.dart';

class MeetView extends StatelessWidget {
  const MeetView({super.key, required this.item, required this.controller});

  static const letterMargin = 40.0;

  final MeetItem item;
  final ItemController controller;

  @override
  Widget build(BuildContext context) {
    final image = item.image;
    return LeoBeside(
      controller: controller,
      child: LayoutBuilder(
        builder: (context, constraints) => Flex(
          direction: constraints.maxWidth > constraints.maxHeight ? Axis.horizontal : Axis.vertical,
          children: [
            for (final option in item.options) Expanded(child: _card(option)),
            if (image != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SvgPicture.asset('assets/images/$image'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _card(String option) => ChoiceButton(
    key: ValueKey('choice-$option'),
    isHighlighted: controller.isHintActive && option == item.target,
    onPressed: () => controller.answer(option),
    child: Padding(
      padding: const EdgeInsets.all(MeetView.letterMargin),
      child: LetterGlyph(_glyphs(option)),
    ),
  );

  String _glyphs(String option) {
    if (option == MeetActivity.bothCases) {
      return '${LetterCase.upper.apply(item.grapheme)}${LetterCase.lower.apply(item.grapheme)}';
    }
    return LetterCase.values.byName(option).apply(item.grapheme);
  }
}
