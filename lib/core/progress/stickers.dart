import '../content/models/content_bundle.dart';
import '../content/models/path_step.dart';

abstract final class Stickers {
  static String? of(ContentBundle content, PathStep step) {
    if (step.icon case final icon?) return icon;
    if (step.word case final word?) return content.wordByText(word)?.image;
    if (step.sounds.isEmpty) return null;
    final taken = {for (final other in content.steps) ?other.word};
    for (final word in content.words) {
      if (word.image != null &&
          !taken.contains(word.text) &&
          word.sounds.isNotEmpty &&
          word.sounds.first == step.sounds.first) {
        return word.image;
      }
    }
    return null;
  }
}
