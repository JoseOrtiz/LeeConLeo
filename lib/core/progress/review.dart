import 'dart:math';

import '../logging/item_event.dart';
import 'mastery.dart';

abstract final class Review {
  static const rounds = 3;
  static const mistakeWeight = 2;

  static List<String> pickSteps(List<ItemEvent> events, Random random, {String? except}) {
    final candidates = (Mastery.masteredSteps(events)..remove(except)).toList()..sort();
    if (candidates.isEmpty) return const [];
    final weights = {
      for (final step in candidates) step: 1 + mistakeWeight * _recentMistakes(events, step),
    };
    final total = weights.values.fold(0, (sum, weight) => sum + weight);
    return [for (var round = 0; round < rounds; round++) _draw(weights, random.nextInt(total))];
  }

  static int _recentMistakes(List<ItemEvent> events, String step) {
    final tries = events.where((event) => event.stepId == step && event.attempt == 1).toList();
    return tries
        .skip(max(0, tries.length - Mastery.window))
        .where((event) => !event.isCorrect)
        .length;
  }

  static String _draw(Map<String, int> weights, int ticket) {
    var left = ticket;
    for (final MapEntry(key: step, value: weight) in weights.entries) {
      if (left < weight) return step;
      left -= weight;
    }
    return weights.keys.last;
  }
}
