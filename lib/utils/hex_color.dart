final _hexColor = RegExp(r'^#([0-9a-fA-F]{6})$');

int? parseHexColor(String hex) {
  final match = _hexColor.firstMatch(hex);
  if (match == null) return null;
  return 0xFF000000 | int.parse(match.group(1)!, radix: 16);
}
