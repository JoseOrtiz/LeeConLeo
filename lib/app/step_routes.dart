import '../activities/activity_registry.dart';
import '../core/content/models/path_step.dart';

abstract final class StepRoutes {
  static String entry(ActivityRegistry registry, PathStep step) {
    final games = registry.available(step.activities);
    return games.length == 1 ? '/play/${step.id}/${games.single}' : '/step/${step.id}';
  }

  static String afterGame(ActivityRegistry registry, PathStep step) =>
      registry.available(step.activities).length == 1 ? '/' : '/step/${step.id}';
}
