import '../logging/item_event.dart';

abstract final class Mastery {
  static const window = 10;
  static const threshold = 0.8;
  static const minSessions = 2;

  static Set<String> masteredSteps(Iterable<ItemEvent> events) {
    final byStep = <String, List<ItemEvent>>{};
    for (final event in events) {
      (byStep[event.stepId] ??= []).add(event);
    }
    return {
      for (final MapEntry(key: step, value: stepEvents) in byStep.entries)
        if (isMastered(stepEvents)) step,
    };
  }

  static bool isMastered(List<ItemEvent> stepEvents) {
    final tries = stepEvents.where((event) => event.attempt == 1).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    if (tries.length < window) return false;
    if (tries.map((event) => event.sessionId).toSet().length < minSessions) return false;
    final recent = tries.sublist(tries.length - window);
    return recent.where((event) => event.isCorrect).length >= window * threshold;
  }
}
