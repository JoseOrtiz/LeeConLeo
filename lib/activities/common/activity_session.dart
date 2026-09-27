import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../core/audio/prompt_player.dart';
import '../../core/content/models/prompt_library.dart';
import '../../core/logging/event_log.dart';
import '../../core/logging/item_event.dart';
import 'activity_item.dart';
import 'activity_prompt_ids.dart';
import 'item_controller.dart';

enum SessionPhase { intro, playing, celebrating, finished }

class ActivitySession extends ChangeNotifier implements ItemController {
  ActivitySession({
    required this.stepId,
    required this.activityId,
    required List<ActivityItem> items,
    required PromptLibrary prompts,
    required PromptPlayer player,
    required EventLog log,
    Random? random,
    DateTime Function()? clock,
    this.mistakesBeforeHint = 2,
  }) : _items = items,
       _prompts = prompts,
       _player = player,
       _log = log,
       _random = random ?? Random(),
       _clock = clock ?? DateTime.now;

  final String stepId;
  final String activityId;
  final int mistakesBeforeHint;
  final List<ActivityItem> _items;
  final PromptLibrary _prompts;
  final PromptPlayer _player;
  final EventLog _log;
  final Random _random;
  final DateTime Function() _clock;

  SessionPhase _phase = SessionPhase.intro;
  int _index = 0;
  int _mistakes = 0;
  DateTime _itemShownAt = DateTime.fromMillisecondsSinceEpoch(0);

  SessionPhase get phase => _phase;

  ActivityItem get currentItem => _items[_index];

  int get itemNumber => _index + 1;

  int get itemCount => _items.length;

  @override
  bool get isHintActive => _mistakes >= mistakesBeforeHint;

  @override
  bool get hasMistake => _mistakes > 0;

  @override
  bool get isSolved => _phase == SessionPhase.celebrating;

  void start() => _say(ActivityPromptIds.intro(activityId));

  void begin() {
    if (_phase != SessionPhase.intro) return;
    _showItem();
  }

  @override
  void answer(String value) {
    if (_phase != SessionPhase.playing) return;
    _record(value);
    if (value == currentItem.target) {
      _phase = SessionPhase.celebrating;
      _say(ActivityPromptIds.correct);
    } else {
      _mistakes++;
      _sayThenRepeatPrompt(isHintActive ? ActivityPromptIds.hint : ActivityPromptIds.retry);
    }
    notifyListeners();
  }

  void next() {
    if (_phase != SessionPhase.celebrating) return;
    if (_index == _items.length - 1) {
      _phase = SessionPhase.finished;
      _say(ActivityPromptIds.reward);
      notifyListeners();
      return;
    }
    _index++;
    _showItem();
  }

  void repeatPrompt() {
    if (_phase == SessionPhase.intro) {
      start();
    } else if (_phase == SessionPhase.playing) {
      _say(currentItem.promptId);
    }
  }

  void _showItem() {
    _phase = SessionPhase.playing;
    _mistakes = 0;
    _itemShownAt = _clock();
    _say(currentItem.promptId);
    notifyListeners();
  }

  void _record(String value) {
    _log.record(
      ItemEvent(
        timestamp: _clock(),
        stepId: stepId,
        activityId: activityId,
        itemId: currentItem.id,
        target: currentItem.target,
        answer: value,
        responseTime: _clock().difference(_itemShownAt),
        attempt: _mistakes + 1,
        hintUsed: isHintActive,
      ),
    );
  }

  void _say(String promptId) => _player.say(_pick(promptId));

  void _sayThenRepeatPrompt(String feedbackId) =>
      _player.say('${_pick(feedbackId)} ${_pick(currentItem.promptId)}');

  String _pick(String promptId) => _prompts.pick(promptId, _random);
}
