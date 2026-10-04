import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/models/spoken_line.dart';
import '../../core/content/models/word.dart';
import '../../core/content/sound_prompt_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'starts_with_view.dart';

class PictureItem extends ActivityItem {
  const PictureItem({
    required super.id,
    required super.target,
    required super.promptId,
    required super.options,
    required super.optionNames,
    required this.images,
  });

  final Map<String, String> images;
}

class StartsWithActivity implements ActivitySpec {
  const StartsWithActivity({this.rounds = 4, this.choices = 4});

  final int rounds;
  final int choices;

  @override
  String get id => ActivityIds.startsWith;

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final sound = context.step.sound!;
    final random = context.random;
    final pictured = context.content.words.where((word) => word.image != null);
    final targets = pictured.where((word) => word.startsWithSound(sound)).toList()..shuffle(random);
    final others = pictured.where((word) => !word.startsWithSound(sound)).toList();
    return [
      for (var round = 0; round < rounds; round++)
        _item(
          round,
          sound,
          targets[round % targets.length],
          (others..shuffle(random)).take(choices - 1),
          random,
        ),
    ];
  }

  PictureItem _item(
    int round,
    String sound,
    Word target,
    Iterable<Word> distractors,
    Random random,
  ) {
    final words = [target, ...distractors]..shuffle(random);
    return PictureItem(
      id: '$round-${target.text}',
      target: target.text,
      promptId: SoundPromptIds.startsWith(sound),
      options: [for (final word in words) word.text],
      optionNames: {for (final word in words) word.text: SpokenLine(word.text, clip: word.audio)},
      images: {for (final word in words) word.text: word.image!},
    );
  }

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      StartsWithView(item: item as PictureItem, controller: controller);
}
