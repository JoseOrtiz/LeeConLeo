import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/profiles/profile_providers.dart';

final leoPositionProvider = NotifierProvider<LeoPosition, String?>(LeoPosition.new);

class LeoPosition extends Notifier<String?> {
  @override
  String? build() {
    ref.watch(activeProfileProvider);
    return null;
  }

  void moveTo(String stepId) => state = stepId;
}
