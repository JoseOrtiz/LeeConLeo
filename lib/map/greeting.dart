import 'package:flutter_riverpod/flutter_riverpod.dart';

final greetingProvider = NotifierProvider<Greeting, bool>(Greeting.new);

class Greeting extends Notifier<bool> {
  @override
  bool build() => false;

  bool takeTurn() {
    if (state) return false;
    state = true;
    return true;
  }
}
