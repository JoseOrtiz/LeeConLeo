import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../activities/activity_providers.dart';
import '../activities/activity_registry.dart';
import '../app/widgets/leo_avatar.dart';
import '../core/content/content_providers.dart';
import '../core/content/models/content_bundle.dart';
import '../core/content/models/path_stage.dart';
import 'step_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentProvider);
    final registry = ref.watch(activityRegistryProvider);

    return Scaffold(
      body: SafeArea(
        child: content.when(
          data: (bundle) => _StageList(bundle: bundle, registry: registry),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
        ),
      ),
    );
  }
}

class _StageList extends StatelessWidget {
  const _StageList({required this.bundle, required this.registry});

  final ContentBundle bundle;
  final ActivityRegistry registry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Center(child: LeoAvatar()),
        for (final stage in bundle.stages) _stageSection(context, stage),
      ],
    );
  }

  Widget _stageSection(BuildContext context, PathStage stage) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stage.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final step in stage.steps)
                StepButton(
                  key: ValueKey('step-${step.id}'),
                  step: step,
                  onPressed: _openAction(context, step.id, step.activities),
                ),
            ],
          ),
        ],
      ),
    );
  }

  VoidCallback? _openAction(BuildContext context, String stepId, List<String> activities) {
    final activityId = registry.firstAvailable(activities);
    if (activityId == null) return null;
    return () => context.go('/play/$stepId/$activityId');
  }
}
