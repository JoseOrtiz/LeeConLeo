import 'package:flutter/widgets.dart';

import '../../core/content/activity_ids.dart';
import '../common/activity_context.dart';
import '../common/activity_item.dart';
import '../common/activity_spec.dart';
import '../common/item_controller.dart';
import 'up_down_view.dart';

class UpDownActivity implements ActivitySpec {
  const UpDownActivity({this.itemCount = 6});

  static const up = 'up';
  static const down = 'down';

  final int itemCount;

  @override
  String get id => ActivityIds.upDown;

  @override
  List<ActivityItem> buildItems(ActivityContext context) => [
    for (var i = 0; i < itemCount; i++) _item(i, context.random.nextBool() ? up : down),
  ];

  @override
  Widget buildItemView(ActivityItem item, ItemController controller) =>
      UpDownView(item: item, controller: controller);

  ActivityItem _item(int index, String target) => ActivityItem(
    id: '$index-$target',
    target: target,
    promptId: '$id.$target',
    options: const [up, down],
  );
}
