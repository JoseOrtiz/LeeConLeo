import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/activities/activity_providers.dart';
import 'package:lee_con_leo/core/content/activity_ids.dart';
import 'package:lee_con_leo/map/game_icons.dart';

void main() {
  test('every game a step can list has an icon picture', () {
    final registry = ProviderContainer().read(activityRegistryProvider);
    for (final game in registry.ids.where((id) => id != ActivityIds.review)) {
      final icon = GameIcons.of(game);
      expect(icon, isNotNull, reason: game);
      expect(File('assets/images/$icon').existsSync(), isTrue, reason: icon);
    }
  });
}
