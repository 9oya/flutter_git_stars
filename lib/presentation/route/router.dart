import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/screens/stars_page.dart';
import 'package:flutter_git_stars/presentation/screens/users_page.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_page.dart';

enum Routes {
  users(
      name: 'users', path: '/users', title: 'Users', iconData: Icons.list_alt),
  stars(name: 'stars', path: '/stars', title: 'Stars', iconData: Icons.star);

  const Routes(
      {required this.name,
      required this.path,
      required this.title,
      required this.iconData});

  final String name;
  final String path;
  final String title;
  final IconData iconData;

  GoRoute get route {
    switch (this) {
      case Routes.users:
        return GoRoute(
          path: path,
          builder: (BuildContext context, GoRouterState state) {
            return UsersPage(
                title: (state.extra as Map<String, String>)['title']);
          },
        );
      case Routes.stars:
        return GoRoute(
          path: path,
          builder: (BuildContext context, GoRouterState state) {
            return StarsPage(
                title: (state.extra as Map<String, String>)['title']);
          },
        );
    }
  }
}

class RouterUtils {
  RouterUtils._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.users.path,
    initialExtra: {'title': Routes.users.title},
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainPage(child: child);
        },
        routes: <RouteBase>[
          Routes.users.route,
          Routes.stars.route,
        ],
      ),
    ],
  );
}
