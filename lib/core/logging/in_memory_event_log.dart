import 'event_log.dart';
import 'item_event.dart';

class InMemoryEventLog implements EventLog {
  final List<ItemEvent> _events = [];

  @override
  void record(ItemEvent event) => _events.add(event);

  @override
  List<ItemEvent> get events => List.unmodifiable(_events);
}
