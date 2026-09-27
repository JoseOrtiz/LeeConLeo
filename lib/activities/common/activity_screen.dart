import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/audio/audio_providers.dart';
import '../../core/content/content_providers.dart';
import '../../core/content/models/content_bundle.dart';
import '../../core/logging/logging_providers.dart';
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

  @override
  void initState() {
    super.initState();
    ref.read(contentProvider.future).then(_startSession);
  }

  void _startSession(ContentBundle content) {
    if (!mounted) return;
    final spec = ref.read(activityRegistryProvider).find(widget.activityId);
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
    });
    session.start();
  }

  void _onSessionChanged() {
    final session = _session!;
    if (session.phase == SessionPhase.celebrating) {
      _celebrationTimer?.cancel();
      _celebrationTimer = Timer(widget.celebrationDuration, session.next);
    }
    setState(() {});
  }

  void _goHome() => context.go('/');

  @override
  void dispose() {
    _celebrationTimer?.cancel();
    _session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody()));
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
        ),
        Expanded(child: _buildPhase(session)),
      ],
    );
  }

  Widget _buildPhase(ActivitySession session) => switch (session.phase) {
    SessionPhase.intro => IntroView(onStart: session.begin),
    SessionPhase.playing ||
    SessionPhase.celebrating => _spec!.buildItemView(session.currentItem, session),
    SessionPhase.finished => RewardView(onDone: _goHome),
  };

  int _completedItems(ActivitySession session) => switch (session.phase) {
    SessionPhase.intro => 0,
    SessionPhase.playing => session.itemNumber - 1,
    SessionPhase.celebrating => session.itemNumber,
    SessionPhase.finished => session.itemCount,
  };
}
