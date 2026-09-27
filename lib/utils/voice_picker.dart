class Voice {
  const Voice({required this.name, required this.locale});

  final String name;
  final String locale;

  bool get isOnline => name.startsWith('Google ') || name.toLowerCase().contains('network');

  String get language => locale.replaceAll('_', '-').toLowerCase();
}

Voice? pickVoice(
  Iterable<Voice> voices,
  List<String> preferredLanguages, {
  String fallback = 'es',
}) {
  final languages = [for (final language in preferredLanguages) language.toLowerCase()];

  int? rankOf(Voice voice) {
    final index = languages.indexOf(voice.language);
    final languageRank = index >= 0
        ? index
        : voice.language.startsWith(fallback)
        ? languages.length
        : null;
    if (languageRank == null) return null;
    return (voice.isOnline ? languages.length + 1 : 0) + languageRank;
  }

  Voice? best;
  int? bestRank;
  for (final voice in voices) {
    final rank = rankOf(voice);
    if (rank != null && (bestRank == null || rank < bestRank)) {
      best = voice;
      bestRank = rank;
    }
  }
  return best;
}
