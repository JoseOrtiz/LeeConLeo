import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/buildable_words.dart';
import '../../core/content/listening_prompt_ids.dart';
import '../../core/content/models/spoken_line.dart';
import '../../core/content/models/word.dart';
import '../../core/content/sound_position.dart';
import '../../core/content/syllable_prompt_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'blend_view.dart';

class BlendItem extends ActivityItem {
  const BlendItem({
    required super.id,
    required super.target,
    required super.promptId,
    required super.options,
    required super.optionNames,
    required super.promptTail,
    required this.syllables,
    required this.images,
  });

  final List<String> syllables;
  final Map<String, String> images;
}

class BlendActivity implements ActivitySpec {
  const BlendActivity({this.rounds = 3, this.choices = 3});

  final int rounds;
  final int choices;

  @override
  String get id => ActivityIds.blend;

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final random = context.random;
    final words = BuildableWords.of(context.content, context.step);
    if (words.isEmpty) return const [];
    final pictured = SoundPosition.pictured(
      context.content.words,
    ).where((word) => word.audio != null).toList();
    final asked = <Word>[];
    while (asked.length < rounds) {
      asked.addAll([...words]..shuffle(random));
    }
    return [
      for (final (round, word) in asked.take(rounds).indexed)
        _item(
          context,
          round,
          word,
          [
            word,
            ...[
              ...(words.where((other) => other != word).toList()..shuffle(random)),
              ...(pictured.where((other) => !words.contains(other)).toList()..shuffle(random)),
            ].take(choices - 1),
          ]..shuffle(random),
        ),
    ];
  }

  BlendItem _item(ActivityContext context, int round, Word word, List<Word> choices) => BlendItem(
    id: '$round-${word.text}',
    target: word.text,
    promptId: SyllablePromptIds.blendAsk,
    promptTail: context.content.prompts.line(
      ListeningPromptIds.clapSplit(word.text),
      context.random,
    ),
    options: [for (final choice in choices) choice.text],
    optionNames: {
      for (final choice in choices) choice.text: SpokenLine(choice.text, clip: choice.audio),
    },
    syllables: word.syllables,
    images: {for (final choice in choices) choice.text: choice.image!},
  );

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      BlendView(item: item as BlendItem, controller: controller);
}
