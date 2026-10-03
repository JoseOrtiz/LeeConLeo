import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/letter_prompt_ids.dart';
import '../../core/content/models/letter_shape.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'find_view.dart';

class FindActivity implements ActivitySpec {
  const FindActivity({this.rounds = 3, this.bubbles = 6, this.targets = 3});

  final int rounds;
  final int bubbles;
  final int targets;

  @override
  String get id => ActivityIds.find;

  static bool isTarget(String bubble, String grapheme) =>
      LetterCase.lower.apply(bubble) == grapheme;

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final grapheme = context.step.grapheme!;
    final distractors = {
      for (final step in context.content.steps)
        if (step.grapheme case final other? when other != grapheme) other,
    }.toList();
    return [
      for (var round = 0; round < rounds; round++)
        ActivityItem(
          id: '$round',
          target: grapheme,
          promptId: LetterPromptIds.find(grapheme),
          options: _board(context, grapheme, distractors),
        ),
    ];
  }

  List<String> _board(ActivityContext context, String grapheme, List<String> distractors) {
    final random = context.random;
    String anyCase(String letter) =>
        (random.nextBool() ? LetterCase.lower : LetterCase.upper).apply(letter);
    final count = distractors.isEmpty ? bubbles : targets;
    return [
      grapheme,
      for (var i = 1; i < count; i++) anyCase(grapheme),
      for (var i = count; i < bubbles; i++)
        anyCase(distractors[random.nextInt(distractors.length)]),
    ]..shuffle(random);
  }

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      FindView(item: item, controller: controller);
}
