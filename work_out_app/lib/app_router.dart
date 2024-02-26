import 'package:go_router/go_router.dart';

import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/routine_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';
import 'package:animations/animations.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/main_screen.dart';

class AppRouter {
  static var router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: palette.bgColor,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: '/planning',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const PlanningScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: palette.bgColor,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: '/workout',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const WorkOutScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: palette.bgColor,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: '/dotsPoint',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const DotsPointScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: palette.bgColor,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: '/createProgram',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const RoutinePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: palette.bgColor,
            child: child,
          ),
        ),
      ),
    ],
  );
}
