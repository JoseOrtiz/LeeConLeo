class PathStep {
  const PathStep({
    required this.id,
    required this.activities,
    this.grapheme,
    this.sounds = const [],
    this.icon,
    this.word,
  });

  factory PathStep.fromJson(Map<String, dynamic> json) => PathStep(
    id: json['id'] as String,
    activities: (json['activities'] as List).cast<String>(),
    grapheme: json['grapheme'] as String?,
    sounds: (json['sounds'] as List? ?? const []).cast<String>(),
    icon: json['icon'] as String?,
    word: json['word'] as String?,
  );

  final String id;
  final List<String> activities;
  final String? grapheme;
  final List<String> sounds;
  final String? icon;
  final String? word;

  Map<String, dynamic> toJson() => {
    'id': id,
    'activities': activities,
    if (grapheme != null) 'grapheme': grapheme,
    if (sounds.isNotEmpty) 'sounds': sounds,
    if (icon != null) 'icon': icon,
    if (word != null) 'word': word,
  };
}
