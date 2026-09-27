import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/core/content/models/prompt_library.dart';

void main() {
  const library = PromptLibrary(
    {
      'feedback.correct': ['¡Muy bien!', '¡Súper!'],
      'reward': ['¡Terminaste!'],
    },
    clips: {'feedback.correct.1': 'prompts/feedback.correct.1.m4a'},
  );

  test('a line carries the clip recorded for its variant', () {
    final lines = [
      for (var seed = 0; seed < 20; seed++) library.line('feedback.correct', Random(seed)),
    ];

    for (final line in lines) {
      expect(line.clip, line.text == '¡Súper!' ? 'prompts/feedback.correct.1.m4a' : isNull);
    }
    expect(lines.map((line) => line.text).toSet(), {'¡Muy bien!', '¡Súper!'});
  });

  test('an unknown prompt gives an empty line without a clip', () {
    final line = library.line('missing', Random(1));
    expect(line.text, isEmpty);
    expect(line.clip, isNull);
  });
}
