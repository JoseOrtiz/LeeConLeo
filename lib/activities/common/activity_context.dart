import 'dart:math';

import '../../core/content/models/content_bundle.dart';
import '../../core/content/models/path_step.dart';

class ActivityContext {
  const ActivityContext({required this.content, required this.step, required this.random});

  final ContentBundle content;
  final PathStep step;
  final Random random;
}
