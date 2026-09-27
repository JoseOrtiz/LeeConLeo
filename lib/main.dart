import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/lee_con_leo_app.dart';
import 'core/audio/audio_providers.dart';
import 'core/progress/device_progress_store.dart';
import 'core/progress/progress_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final progress = await DeviceProgressStore.open();
  final container = ProviderContainer(
    overrides: [progressStoreProvider.overrideWithValue(progress)],
  );
  container.read(promptPlayerProvider).prepare();
  runApp(UncontrolledProviderScope(container: container, child: const LeeConLeoApp()));
}
