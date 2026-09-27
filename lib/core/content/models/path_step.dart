class PathStep {
  const PathStep({
    required this.id,
    required this.activities,
    this.grapheme,
    this.sound,
    this.icon,
  });

  factory PathStep.fromJson(Map<String, dynamic> json) => PathStep(
    id: json['id'] as String,
    activities: (json['activities'] as List).cast<String>(),
    grapheme: json['grapheme'] as String?,
    sound: json['sound'] as String?,
    icon: json['icon'] as String?,
  );

  final String id;
  final List<String> activities;
  final String? grapheme;
  final String? sound;
  final String? icon;

  Map<String, dynamic> toJson() => {
    'id': id,
    'activities': activities,
    if (grapheme != null) 'grapheme': grapheme,
    if (sound != null) 'sound': sound,
    if (icon != null) 'icon': icon,
  };
}
