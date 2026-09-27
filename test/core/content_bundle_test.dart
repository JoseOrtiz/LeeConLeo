import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/asset_content_repository.dart';
import 'package:lee_con_leo/core/content/models/content_bundle.dart';

void main() {
  final json =
      jsonDecode(File(AssetContentRepository.bundlePath).readAsStringSync())
          as Map<String, dynamic>;
  final bundle = ContentBundle.fromJson(json);

  test('the generated bundle loads', () {
    expect(bundle.words, isNotEmpty);
    expect(bundle.stepById('up-down'), isNotNull);
  });

  test('serializing the bundle gives back the same json', () {
    expect(bundle.toJson(), json);
  });
}
