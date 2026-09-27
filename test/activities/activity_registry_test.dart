import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/activity_providers.dart';
import 'package:lee_con_leo/core/content/activity_ids.dart';

void main() {
  final registry = ProviderContainer().read(activityRegistryProvider);

  test('every registered activity has a known id', () {
    expect(ActivityIds.all, containsAll(registry.ids));
  });

  test('firstAvailable skips activities that are not built yet', () {
    expect(registry.firstAvailable([ActivityIds.meet, ActivityIds.upDown]), ActivityIds.upDown);
    expect(registry.firstAvailable([ActivityIds.meet]), isNull);
  });
}
