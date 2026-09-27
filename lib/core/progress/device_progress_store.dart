import 'package:shared_preferences/shared_preferences.dart';

import 'progress_store.dart';

class DeviceProgressStore implements ProgressStore {
  DeviceProgressStore._(this._preferences);

  static const completedKey = 'progress.completedSteps';

  static Future<DeviceProgressStore> open() async => DeviceProgressStore._(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: {completedKey}),
    ),
  );

  final SharedPreferencesWithCache _preferences;

  @override
  Set<String> get completedSteps => {...?_preferences.getStringList(completedKey)};

  @override
  Future<void> markCompleted(String stepId) =>
      _preferences.setStringList(completedKey, [...completedSteps, stepId]..sort());
}
