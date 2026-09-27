abstract interface class ItemController {
  bool get isHintActive;

  bool get hasMistake;

  bool get isSolved;

  void answer(String value);
}
