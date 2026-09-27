import 'package:yaml/yaml.dart';

Object? yamlToDart(Object? node) => switch (node) {
  final YamlMap map => {
    for (final entry in map.entries) entry.key.toString(): yamlToDart(entry.value),
  },
  final YamlList list => [for (final item in list) yamlToDart(item)],
  _ => node,
};
