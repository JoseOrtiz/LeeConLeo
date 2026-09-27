import 'dart:convert';
import 'dart:io';

import 'package:lee_con_leo/core/content/models/content_bundle.dart';

class BundleWriter {
  const BundleWriter(this.path);

  final String path;

  static const _encoder = JsonEncoder.withIndent('  ');

  void write(ContentBundle bundle) {
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(_encode(bundle));
  }

  bool isUpToDate(ContentBundle bundle) {
    final file = File(path);
    return file.existsSync() && file.readAsStringSync() == _encode(bundle);
  }

  String _encode(ContentBundle bundle) => '${_encoder.convert(bundle.toJson())}\n';
}
