abstract interface class ItemController {
  bool get isHintActive;

  bool get hasMistake;

  bool get isSolved;

  bool get showsDemo;

  void answer(String value);
}
