import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list_app/task/pages/new_task_screen.dart';
import '../../splash/view/splash_page.dart';
import '../../task/pages/tasks_screen.dart';

class Routes {

  /// The route configuration.
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      /// Flow for unregistered/non-logged-in user launched first time
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'task_page',
            builder: (BuildContext context, GoRouterState state) {
              return const TasksScreen();
            },
          )
        ],
      ),

      /// Flow for logged-in user launched first time
      GoRoute(
        path: '/task_page',
        builder: (BuildContext context, GoRouterState state) {
          return const TasksScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'new_task_page',
            builder: (BuildContext context, GoRouterState state) {
              return const NewTaskScreen();
            },
          )
        ],
      )
    ],
  );

}