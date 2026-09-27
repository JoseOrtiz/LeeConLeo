import 'path_step.dart';

class PathStage {
  const PathStage({required this.stage, required this.name, required this.steps});

  factory PathStage.fromJson(Map<String, dynamic> json) => PathStage(
    stage: json['stage'] as int,
    name: json['name'] as String,
    steps: [
      for (final step in json['steps'] as List) PathStep.fromJson(step as Map<String, dynamic>),
    ],
  );

  final int stage;
  final String name;
  final List<PathStep> steps;

  Map<String, dynamic> toJson() => {
    'stage': stage,
    'name': name,
    'steps': [for (final step in steps) step.toJson()],
  };
}
