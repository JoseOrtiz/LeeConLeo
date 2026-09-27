import 'item_event.dart';

abstract interface class EventLog {
  void record(ItemEvent event);

  List<ItemEvent> get events;
}
