abstract final class ActivityPromptIds {
  static const correct = 'feedback.correct';
  static const retry = 'feedback.retry';
  static const hint = 'feedback.hint';
  static const reward = 'reward';

  static String intro(String activityId) => '$activityId.intro';
}
