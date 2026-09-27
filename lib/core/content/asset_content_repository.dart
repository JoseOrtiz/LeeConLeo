import 'dart:convert';

import 'package:flutter/services.dart';

import 'content_repository.dart';
import 'models/content_bundle.dart';

class AssetContentRepository implements ContentRepository {
  AssetContentRepository(this._assets);

  static const bundlePath = 'assets/content/bundle.json';

  final AssetBundle _assets;

  @override
  Future<ContentBundle> load() async {
    final json = jsonDecode(await _assets.loadString(bundlePath)) as Map<String, dynamic>;
    return ContentBundle.fromJson(json);
  }
}
