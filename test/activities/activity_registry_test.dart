import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/activity_providers.dart';
import 'package:lee_con_leo/core/content/activity_ids.dart';

const _unbuilt = 'syllables.not_built';

void main() {
  final registry = ProviderContainer().read(activityRegistryProvider);

  test('every registered activity has a known id', () {
    expect(ActivityIds.all, containsAll(registry.ids));
  });

  test('firstAvailable skips activities that are not built yet', () {
    expect(registry.firstAvailable([_unbuilt, ActivityIds.upDown]), ActivityIds.upDown);
    expect(registry.firstAvailable([_unbuilt]), isNull);
  });

  test('nextAvailable gives the following built activity of a step', () {
    const step = [ActivityIds.meet, _unbuilt, ActivityIds.find];

    expect(registry.nextAvailable(step, after: ActivityIds.meet), ActivityIds.find);
    expect(registry.nextAvailable(step, after: ActivityIds.find), isNull);
  });
}
