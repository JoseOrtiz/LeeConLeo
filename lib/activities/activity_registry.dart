import 'common/activity_spec.dart';

class ActivityRegistry {
  ActivityRegistry(List<ActivitySpec> specs) : _specs = {for (final spec in specs) spec.id: spec};

  final Map<String, ActivitySpec> _specs;

  Iterable<String> get ids => _specs.keys;

  ActivitySpec? find(String id) => _specs[id];

  String? firstAvailable(List<String> activityIds) {
    for (final id in activityIds) {
      if (_specs.containsKey(id)) return id;
    }
    return null;
  }
}
