class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.target,
    required this.promptId,
    required this.options,
  });

  final String id;
  final String target;
  final String promptId;
  final List<String> options;
}
