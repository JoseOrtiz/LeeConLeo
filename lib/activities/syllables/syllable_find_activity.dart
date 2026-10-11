import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/syllable_prompt_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import '../letters/find_view.dart';

class SyllableFindActivity implements ActivitySpec {
  const SyllableFindActivity({
    this.rounds = 3,
    this.bubbles = 6,
    this.targets = 2,
    this.sameFamily = 2,
  });

  final int rounds;
  final int bubbles;
  final int targets;
  final int sameFamily;

  @override
  String get id => ActivityIds.syllableFind;

  static String capitalized(String syllable) =>
      '${syllable[0].toUpperCase()}${syllable.substring(1)}';

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final family = context.step.sounds;
    final others = {
      for (final step in context.content.steps)
        if (step.sounds.length > 1 && step.id != context.step.id) ...step.sounds,
    }.toList();
    final asked = ([...family]..shuffle(context.random)).take(rounds);
    return [
      for (final (round, sound) in asked.indexed)
        ActivityItem(
          id: '$round-$sound',
          target: sound,
          promptId: SyllablePromptIds.find(sound),
          options: _board(context, sound, family, others),
        ),
    ];
  }

  List<String> _board(
    ActivityContext context,
    String sound,
    List<String> family,
    List<String> others,
  ) {
    final random = context.random;
    String anyCase(String syllable) => random.nextBool() ? capitalized(syllable) : syllable;
    final cousins = family.where((other) => other != sound).toList()..shuffle(random);
    final strangers = [...others]..shuffle(random);
    final fromFamily = others.isEmpty ? bubbles - targets : sameFamily;
    final distractors = [
      ...cousins.take(fromFamily),
      ...strangers.take(bubbles - targets - fromFamily),
    ];
    while (distractors.length < bubbles - targets) {
      distractors.add(cousins[random.nextInt(cousins.length)]);
    }
    return [
      sound,
      for (var i = 1; i < targets; i++) anyCase(sound),
      for (final distractor in distractors) anyCase(distractor),
    ]..shuffle(random);
  }

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      FindView(item: item, controller: controller);
}
