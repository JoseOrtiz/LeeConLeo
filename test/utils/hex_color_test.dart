import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/utils/hex_color.dart';

void main() {
  test('reads a six-digit color as an opaque ARGB value', () {
    expect(parseHexColor('#EEF7E4'), 0xFFEEF7E4);
    expect(parseHexColor('#fdf4de'), 0xFFFDF4DE);
  });

  test('rejects anything that is not #RRGGBB', () {
    for (final bad in ['EEF7E4', '#EEF', '#EEF7E4FF', '#GGGGGG', '']) {
      expect(parseHexColor(bad), isNull, reason: bad);
    }
  });
}
