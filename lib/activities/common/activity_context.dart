import 'dart:math';

import '../../core/content/models/content_bundle.dart';
import '../../core/content/models/path_step.dart';
import '../../core/logging/item_event.dart';

class ActivityContext {
  const ActivityContext({
    required this.content,
    required this.step,
    required this.random,
    this.events = const [],
  });

  final ContentBundle content;
  final PathStep step;
  final Random random;
  final List<ItemEvent> events;
}
