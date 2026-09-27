import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'positions_scene.dart';
import 'positions_view.dart';

class PositionsActivity implements ActivitySpec {
  const PositionsActivity({this.roundsPerPosition = 2});

  static const positions = [PositionsScene.over, PositionsScene.under, PositionsScene.between];

  final int roundsPerPosition;

  @override
  String get id => ActivityIds.positions;

  @override
  List<ActivityItem> buildItems(ActivityContext context) {
    final targets = [for (var round = 0; round < roundsPerPosition; round++) ...positions]
      ..shuffle(context.random);
    return [
      for (final (index, target) in targets.indexed)
        ActivityItem(
          id: '$index-$target',
          target: target,
          promptId: '$id.$target',
          options: positions,
        ),
    ];
  }

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      PositionsView(item: item, controller: controller);
}
