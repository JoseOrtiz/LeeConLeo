import 'package:lee_con_leo/core/logging/item_event.dart';

List<ItemEvent> firstTries(
  String stepId, {
  required int correct,
  int wrong = 0,
  List<String> sessions = const ['s1', 's2'],
}) => [
  for (var i = 0; i < correct + wrong; i++)
    ItemEvent(
      timestamp: DateTime(2026, 10, 1).add(Duration(minutes: i)),
      sessionId: sessions[i * sessions.length ~/ (correct + wrong)],
      stepId: stepId,
      activityId: 'letter.meet',
      itemId: '$i',
      target: 'a',
      answer: i < wrong ? 'e' : 'a',
      responseTime: const Duration(seconds: 2),
      attempt: 1,
      hintUsed: false,
    ),
];
