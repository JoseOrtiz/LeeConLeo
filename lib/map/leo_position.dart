import 'package:flutter_riverpod/flutter_riverpod.dart';

final leoPositionProvider = NotifierProvider<LeoPosition, String?>(LeoPosition.new);

class LeoPosition extends Notifier<String?> {
  @override
  String? build() => null;

  void moveTo(String stepId) => state = stepId;
}
