import '../../core/content/models/spoken_line.dart';

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.target,
    required this.promptId,
    required this.options,
    this.optionNames = const {},
  });

  final String id;
  final String target;
  final String promptId;
  final List<String> options;
  final Map<String, SpokenLine> optionNames;
}
