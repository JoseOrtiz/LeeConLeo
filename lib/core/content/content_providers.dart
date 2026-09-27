import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'asset_content_repository.dart';
import 'content_repository.dart';
import 'models/content_bundle.dart';

final contentRepositoryProvider = Provider<ContentRepository>(
  (ref) => AssetContentRepository(rootBundle),
);

final contentProvider = FutureProvider<ContentBundle>(
  (ref) => ref.watch(contentRepositoryProvider).load(),
);
