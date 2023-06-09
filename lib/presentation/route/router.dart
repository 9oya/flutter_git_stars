import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/screens/stars/stars_page.dart';
import 'package:flutter_git_stars/presentation/screens/users/users_page.dart';
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
            // final Map<String, dynamic> extra =
            //     state.extra as Map<String, dynamic>;
            return const UsersPage(title: 'Users');
          },
        );
      case Routes.stars:
        return GoRoute(
          path: path,
          builder: (BuildContext context, GoRouterState state) {
            // final Map<String, dynamic> extra =
            //     state.extra as Map<String, dynamic>;
            return const StarsPage(title: 'Stars');
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
  final GlobalKey<NavigatorState> _sectionANavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

  static final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.users.path,
      initialExtra: {
        'title': Routes.users.title
      },
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
            builder: (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return MainPage(navigationShell: navigationShell);
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(routes: <RouteBase>[
                Routes.users.route,
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                Routes.stars.route,
              ]),
            ])
      ]);
}
