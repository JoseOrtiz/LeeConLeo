import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/lee_con_leo_app.dart';
import 'core/audio/audio_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(promptPlayerProvider).prepare();
  runApp(UncontrolledProviderScope(container: container, child: const LeeConLeoApp()));
}
