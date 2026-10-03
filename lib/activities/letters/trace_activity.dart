import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../../core/content/letter_prompt_ids.dart';
import '../../core/content/models/letter_shape.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'trace_view.dart';

class TraceItem extends ActivityItem {
  const TraceItem({
    required super.id,
    required super.target,
    required super.promptId,
    required this.strokes,
  }) : super(options: const []);

  final List<Stroke> strokes;
}

class TraceActivity implements ActivitySpec {
  const TraceActivity();

  @override
  String get id => ActivityIds.trace;

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final grapheme = context.step.grapheme!;
    final shape = context.content.letters[grapheme]!;
    return [
      for (final (index, letterCase) in LetterCase.values.indexed)
        TraceItem(
          id: '$index-${letterCase.name}',
          target: letterCase.apply(grapheme),
          promptId: LetterPromptIds.trace(grapheme, letterCase),
          strokes: shape.strokes(letterCase),
        ),
    ];
  }

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      TraceView(item: item as TraceItem, controller: controller);
}
