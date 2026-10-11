import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/profiles/profile_providers.dart';

final reviewDueProvider = NotifierProvider<ReviewDue, bool>(ReviewDue.new);

class ReviewDue extends Notifier<bool> {
  @override
  bool build() {
    ref.watch(activeProfileProvider);
    return true;
  }

  void markDone() => state = false;
}
