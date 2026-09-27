import 'package:flutter/widgets.dart';

import 'activity_context.dart';
import 'activity_item.dart';
import 'item_controller.dart';

abstract interface class ActivitySpec {
  String get id;

  List<ActivityItem> buildItems(ActivityContext context);

  Widget buildItemView(ActivityItem item, ItemController controller);
}
