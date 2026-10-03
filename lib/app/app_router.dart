import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../activities/common/activity_screen.dart';
import '../map/home_screen.dart';

GoRouter createAppRouter() => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/play/:stepId/:activityId',
      builder: (context, state) => ActivityScreen(
        key: ValueKey(state.uri.path),
        stepId: state.pathParameters['stepId']!,
        activityId: state.pathParameters['activityId']!,
      ),
    ),
  ],
);
