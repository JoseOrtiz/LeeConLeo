import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'prompt_player.dart';
import 'tts_prompt_player.dart';

final promptPlayerProvider = Provider<PromptPlayer>((ref) => TtsPromptPlayer());
