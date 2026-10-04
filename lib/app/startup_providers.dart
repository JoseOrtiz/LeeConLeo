import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/content/content_providers.dart';
import '../core/content/models/content_bundle.dart';

final minimumSplashProvider = Provider<Duration>((ref) => const Duration(milliseconds: 1500));

final startupProvider = FutureProvider<ContentBundle>((ref) async {
  final minimum = Future<void>.delayed(ref.watch(minimumSplashProvider));
  final content = await ref.watch(contentProvider.future);
  await minimum;
  return content;
});
