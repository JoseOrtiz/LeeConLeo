import 'event_log.dart';
import 'item_event.dart';

class InMemoryEventLog implements EventLog {
  InMemoryEventLog([Iterable<ItemEvent> events = const []]) : _events = [...events];

  final List<ItemEvent> _events;

  @override
  void record(ItemEvent event) => _events.add(event);

  @override
  List<ItemEvent> get events => List.unmodifiable(_events);
}
