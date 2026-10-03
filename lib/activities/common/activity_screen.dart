import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/audio/audio_providers.dart';
import '../../core/content/content_providers.dart';
import '../../core/content/models/content_bundle.dart';
import '../../core/content/models/path_stage.dart';
import '../../core/logging/logging_providers.dart';
import '../../core/progress/progress_providers.dart';
import '../../app/widgets/scene_band.dart';
import '../../utils/hex_color.dart';
import '../activity_providers.dart';
import 'activity_context.dart';
import 'activity_session.dart';
import 'activity_spec.dart';
import 'widgets/activity_top_bar.dart';
import 'widgets/intro_view.dart';
import 'widgets/reward_view.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({
    super.key,
    required this.stepId,
    required this.activityId,
    this.celebrationDuration = const Duration(milliseconds: 1500),
    this.random,
  });

  final String stepId;
  final String activityId;
  final Duration celebrationDuration;
  final Random? random;

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  ActivitySpec? _spec;
  ActivitySession? _session;
  Timer? _celebrationTimer;
  bool _isUnavailable = false;
  PathStage? _stage;
  String? _nextActivityId;

  @override
  void initState() {
    super.initState();
    ref.read(contentProvider.future).then(_startSession);
  }

  void _startSession(ContentBundle content) {
    if (!mounted) return;
    final registry = ref.read(activityRegistryProvider);
    final spec = registry.find(widget.activityId);
    final step = content.stepById(widget.stepId);
    if (spec == null || step == null) {
      setState(() => _isUnavailable = true);
      return;
    }

    final random = widget.random ?? Random();
    final session = ActivitySession(
      stepId: step.id,
      activityId: spec.id,
      items: spec.buildItems(ActivityContext(content: content, step: step, random: random)),
      prompts: content.prompts,
      player: ref.read(promptPlayerProvider),
      log: ref.read(eventLogProvider),
      random: random,
    )..addListener(_onSessionChanged);

    setState(() {
      _spec = spec;
      _session = session;
      _stage = content.stageOf(step.id);
      _nextActivityId = registry.nextAvailable(step.activities, after: spec.id);
    });
    session.start();
  }

  void _onSessionChanged() {
    final session = _session!;
    if (session.phase == SessionPhase.celebrating) {
      _celebrationTimer?.cancel();
      _celebrationTimer = Timer(widget.celebrationDuration, session.next);
    }
    if (session.phase == SessionPhase.finished && _nextActivityId == null) {
      ref.read(completedStepsProvider.notifier).markCompleted(session.stepId);
    }
    setState(() {});
  }

  void _goHome() {
    ref.read(promptPlayerProvider).stop();
    context.go('/');
  }

  void _continue() {
    final next = _nextActivityId;
    if (next == null) return _goHome();
    ref.read(promptPlayerProvider).stop();
    context.go('/play/${widget.stepId}/$next');
  }

  @override
  void dispose() {
    _celebrationTimer?.cancel();
    _session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scene = _stage?.scene;
    final showScene = scene != null && _showsScene;
    return Scaffold(
      backgroundColor: _tint,
      body: Stack(
        children: [
          if (showScene) Positioned.fill(child: SceneBand(asset: 'assets/images/$scene')),
          SafeArea(child: _buildBody()),
        ],
      ),
    );
  }

  bool get _showsScene {
    final phase = _session?.phase;
    return _isUnavailable || phase == SessionPhase.intro || phase == SessionPhase.finished;
  }

  Color? get _tint {
    final tint = _stage?.tint;
    final argb = tint == null ? null : parseHexColor(tint);
    return argb == null ? null : Color(argb);
  }

  Widget _buildBody() {
    if (_isUnavailable) return RewardView(onDone: _goHome);
    final session = _session;
    if (session == null) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        ActivityTopBar(
          onHome: _goHome,
          onRepeat: session.repeatPrompt,
          completed: _completedItems(session),
          total: session.itemCount,
          showsProgress: !_showsScene,
        ),
        Expanded(child: _buildPhase(session)),
      ],
    );
  }

  Widget _buildPhase(ActivitySession session) => switch (session.phase) {
    SessionPhase.intro => IntroView(onStart: session.begin),
    SessionPhase.playing ||
    SessionPhase.celebrating => _spec!.buildItemView(session.currentItem, session),
    SessionPhase.finished => RewardView(onDone: _continue),
  };

  int _completedItems(ActivitySession session) => switch (session.phase) {
    SessionPhase.intro => 0,
    SessionPhase.playing => session.itemNumber - 1,
    SessionPhase.celebrating => session.itemNumber,
    SessionPhase.finished => session.itemCount,
  };
}
