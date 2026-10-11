import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/models/spoken_line.dart';
import '../../core/content/sound_clips.dart';
import '../../core/content/syllable_prompt_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'syllable_meet_view.dart';

class SyllableItem extends ActivityItem {
  const SyllableItem({
    required super.id,
    required super.target,
    required super.promptId,
    required super.options,
    super.optionNames,
    this.parts = const [],
  });

  final List<String> parts;
}

class SyllableMeetActivity implements ActivitySpec {
  const SyllableMeetActivity({this.choiceRounds = 3, this.choices = 3});

  final int choiceRounds;
  final int choices;

  @override
  String get id => ActivityIds.syllableMeet;

  static List<String> parts(String syllable) => [
    syllable.substring(0, syllable.length - 1),
    syllable.substring(syllable.length - 1),
  ];

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final sounds = context.step.sounds;
    final random = context.random;
    final asked = ([...sounds]..shuffle(random)).take(choiceRounds);
    return [
      for (final (index, sound) in sounds.indexed)
        SyllableItem(
          id: '$index-$sound',
          target: sound,
          promptId: SyllablePromptIds.meet(sound),
          options: [sound],
          parts: parts(sound),
        ),
      for (final (round, sound) in asked.indexed)
        _choice(
          sounds.length + round,
          sound,
          [
            sound,
            ...(sounds.where((other) => other != sound).toList()..shuffle(random)).take(
              choices - 1,
            ),
          ]..shuffle(random),
        ),
    ];
  }

  SyllableItem _choice(int index, String sound, List<String> options) => SyllableItem(
    id: '$index-$sound',
    target: sound,
    promptId: SyllablePromptIds.choose(sound),
    options: options,
    optionNames: {
      for (final option in options) option: SpokenLine(option, clip: SoundClips.of(option)),
    },
  );

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      SyllableMeetView(item: item as SyllableItem, controller: controller);
}
