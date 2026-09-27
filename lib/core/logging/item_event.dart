class ItemEvent {
  const ItemEvent({
    required this.timestamp,
    required this.stepId,
    required this.activityId,
    required this.itemId,
    required this.target,
    required this.answer,
    required this.responseTime,
    required this.attempt,
    required this.hintUsed,
  });

  final DateTime timestamp;
  final String stepId;
  final String activityId;
  final String itemId;
  final String target;
  final String answer;
  final Duration responseTime;
  final int attempt;
  final bool hintUsed;

  bool get isCorrect => answer == target;
}
