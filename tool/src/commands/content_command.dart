abstract interface class ContentCommand {
  String get name;

  String get usage;

  int run(List<String> arguments);
}
