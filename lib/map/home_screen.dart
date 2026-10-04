import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../activities/activity_providers.dart';
import '../app/app_theme.dart';
import '../app/widgets/leo_avatar.dart';
import '../app/startup_providers.dart';
import '../app/widgets/loading_view.dart';
import '../app/widgets/pulse.dart';
import '../core/audio/audio_providers.dart';
import '../core/audio/utterance.dart';
import '../core/content/models/content_bundle.dart';
import '../core/content/models/path_step.dart';
import '../core/progress/progress_providers.dart';
import 'greeting.dart';
import 'label_slot.dart';
import 'leo_position.dart';
import 'path_layout.dart';
import 'route_painter.dart';
import '../app/widgets/scene_band.dart';
import 'step_button.dart';
import 'step_status.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: ref
            .watch(startupProvider)
            .when(
              data: (bundle) => PathMap(bundle: bundle),
              loading: () => const LoadingView(),
              error: (error, _) => Center(child: Text('$error')),
            ),
      ),
    );
  }
}

class PathMap extends ConsumerStatefulWidget {
  const PathMap({super.key, required this.bundle});

  static const walkDuration = Duration(milliseconds: 900);
  static const maxWidth = 560.0;
  static const introPrompt = 'home.intro';
  static const lockedPrompt = 'home.locked';
  static const labelMargin = 16.0;
  static const labelHeight = 44.0;

  final ContentBundle bundle;

  @override
  ConsumerState<PathMap> createState() => _PathMapState();
}

class _PathMapState extends ConsumerState<PathMap> {
  final _leoKey = GlobalKey();
  final _random = Random();
  Timer? _showLeoTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _arrive());
  }

  void _arrive() {
    if (!mounted) return;
    if (ref.read(greetingProvider.notifier).takeTurn()) _say(PathMap.introPrompt);
    final target = _leoTarget(_statuses(ref.read(completedStepsProvider)));
    if (target != null && ref.read(leoPositionProvider) != target) {
      ref.read(leoPositionProvider.notifier).moveTo(target);
    }
    _showLeoTimer = Timer(PathMap.walkDuration, _showLeo);
  }

  @override
  void dispose() {
    _showLeoTimer?.cancel();
    super.dispose();
  }

  void _showLeo() {
    final leo = _leoKey.currentContext;
    if (!mounted || leo == null) return;
    Scrollable.ensureVisible(leo, alignment: 0.5, duration: const Duration(milliseconds: 400));
  }

  void _say(String promptId) => ref
      .read(promptPlayerProvider)
      .say(Utterance([widget.bundle.prompts.line(promptId, _random)]));

  Map<String, StepStatus> _statuses(Set<String> completed) {
    final registry = ref.read(activityRegistryProvider);
    return stepStatuses(
      widget.bundle.steps,
      completed: completed,
      isPlayable: (step) => registry.firstAvailable(step.activities) != null,
    );
  }

  String? _leoTarget(Map<String, StepStatus> statuses) {
    for (final MapEntry(key: id, value: status) in statuses.entries) {
      if (status == StepStatus.next) return id;
    }
    final done = [
      for (final MapEntry(key: id, value: status) in statuses.entries)
        if (status == StepStatus.done) id,
    ];
    return done.isEmpty ? null : done.last;
  }

  void _open(PathStep step, StepStatus status) {
    final activityId = ref.read(activityRegistryProvider).firstAvailable(step.activities);
    if (status == StepStatus.locked || activityId == null) {
      _say(PathMap.lockedPrompt);
      return;
    }
    context.go('/play/${step.id}/$activityId');
  }

  @override
  Widget build(BuildContext context) {
    final statuses = _statuses(ref.watch(completedStepsProvider));
    final leoAt = ref.watch(leoPositionProvider) ?? _leoTarget(statuses);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final layout = PathLayout.fit(
          width: min(width, PathMap.maxWidth),
          stages: widget.bundle.stages,
          minHeight: constraints.maxHeight,
        );
        final inset = (width - layout.width) / 2;
        final road = RoutePainter.through([
          for (final step in widget.bundle.steps) layout.stepCenters[step.id]! + Offset(inset, 0),
        ]);
        return SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            width: width,
            height: layout.height,
            child: Stack(
              children: [
                for (final (index, stage) in widget.bundle.stages.indexed) ...[
                  Positioned(
                    left: 0,
                    right: 0,
                    top: layout.stageBands[index].top,
                    height: layout.stageBands[index].height + SceneBand.seamOverlap,
                    child: _scene(stage.scene),
                  ),
                  _label(stage.name, layout.stageBands[index].top, road, width),
                ],
                Positioned(
                  left: (width - layout.width) / 2,
                  top: 0,
                  width: layout.width,
                  height: layout.height,
                  child: Stack(children: _route(layout, statuses, leoAt)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _route(PathLayout layout, Map<String, StepStatus> statuses, String? leoAt) => [
    Positioned.fill(
      child: CustomPaint(
        painter: RoutePainter(
          points: [for (final step in widget.bundle.steps) layout.stepCenters[step.id]!],
          edge: AppTheme.outline,
          road: AppTheme.road,
        ),
      ),
    ),
    for (final step in widget.bundle.steps)
      Positioned.fromRect(
        rect: layout.stoneOf(step.id),
        child: _pulseIfNext(
          statuses[step.id]!,
          StepButton(
            key: ValueKey('step-${step.id}'),
            step: step,
            status: statuses[step.id]!,
            onPressed: () => _open(step, statuses[step.id]!),
          ),
        ),
      ),
    if (leoAt != null)
      AnimatedPositioned.fromRect(
        rect: layout.leoBeside(leoAt),
        duration: PathMap.walkDuration,
        curve: Curves.easeInOut,
        child: IgnorePointer(
          child: LeoAvatar(key: _leoKey, size: PathLayout.leoHeight),
        ),
      ),
  ];

  Widget _label(String name, double bandTop, Path road, double width) {
    final top = bandTop + PathMap.labelMargin;
    final slot = labelSlot(
      road: road,
      roadHalfWidth: RoutePainter.halfWidth,
      top: top,
      bottom: top + PathMap.labelHeight,
      width: width,
      margin: PathMap.labelMargin,
    );
    return Positioned(
      left: slot.isLeft ? PathMap.labelMargin : null,
      right: slot.isLeft ? null : PathMap.labelMargin,
      top: top,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: slot.maxWidth),
        child: _StageLabel(key: ValueKey('stage-label-$name'), name: name),
      ),
    );
  }

  Widget _pulseIfNext(StepStatus status, Widget stone) =>
      status == StepStatus.next ? Pulse(child: stone) : stone;

  Widget _scene(String? scene) => scene == null
      ? ColoredBox(color: Theme.of(context).colorScheme.surfaceContainerLow)
      : SceneBand(asset: 'assets/images/$scene');
}

class _StageLabel extends StatelessWidget {
  const _StageLabel({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(name, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
