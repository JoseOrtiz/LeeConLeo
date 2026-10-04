import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'asset_clip_speaker.dart';
import 'clip_prompt_player.dart';
import 'pausable_prompt_player.dart';
import 'prompt_player.dart';
import 'tts_prompt_player.dart';

final pausablePlayerProvider = Provider<PausablePromptPlayer>(
  (ref) => PausablePromptPlayer(
    ClipPromptPlayer(speaker: AssetClipSpeaker(), fallback: TtsPromptPlayer()),
  ),
);

final promptPlayerProvider = Provider<PromptPlayer>((ref) => ref.watch(pausablePlayerProvider));
