import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'asset_clip_speaker.dart';
import 'clip_prompt_player.dart';
import 'prompt_player.dart';
import 'tts_prompt_player.dart';

final promptPlayerProvider = Provider<PromptPlayer>(
  (ref) => ClipPromptPlayer(speaker: AssetClipSpeaker(), fallback: TtsPromptPlayer()),
);
