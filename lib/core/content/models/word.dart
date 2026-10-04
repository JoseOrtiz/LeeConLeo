class Word {
  const Word({
    required this.text,
    required this.syllables,
    required this.sounds,
    this.image,
    this.audio,
    this.tags = const [],
    this.minStage = 0,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    text: json['text'] as String,
    syllables: _strings(json['syllables']),
    sounds: _strings(json['sounds']),
    image: json['image'] as String?,
    audio: json['audio'] as String?,
    tags: _strings(json['tags']),
    minStage: json['minStage'] as int? ?? 0,
  );

  final String text;
  final List<String> syllables;
  final List<String> sounds;
  final String? image;
  final String? audio;
  final List<String> tags;
  final int minStage;

  String get firstSound => sounds.first;

  String get lastSound => sounds.last;

  bool startsWithSound(String sound) => sounds.isNotEmpty && sounds.first.startsWith(sound);

  Map<String, dynamic> toJson() => {
    'text': text,
    'syllables': syllables,
    'sounds': sounds,
    if (image != null) 'image': image,
    if (audio != null) 'audio': audio,
    if (tags.isNotEmpty) 'tags': tags,
    if (minStage != 0) 'minStage': minStage,
  };

  static List<String> _strings(Object? value) =>
      value == null ? const [] : (value as List).cast<String>();
}
