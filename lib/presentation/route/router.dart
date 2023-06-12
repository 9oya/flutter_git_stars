import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/screens/stars/stars_page.dart';
import 'package:flutter_git_stars/presentation/screens/users/detail/user_detail_page.dart';
import 'package:flutter_git_stars/presentation/screens/users/users_page.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_page.dart';

enum RouteInfo {
  users(name: 'users', title: 'Users', iconData: Icons.list_alt),
  stars(name: 'stars', title: 'Stars', iconData: Icons.star),
  detail(name: 'detail', title: null, iconData: null);

  const RouteInfo(
      {required this.name, required this.title, required this.iconData});

  final String name;
  final String? title;
  final IconData? iconData;
}

class RouterUtils {
  RouterUtils._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/${RouteInfo.users.name}',
      initialExtra: {
        'title': RouteInfo.users.title
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
                GoRoute(
                    path: '/${RouteInfo.users.name}',
                    builder: (BuildContext context, GoRouterState state) {
                      return const UsersPage(title: 'Users');
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        path: RouteInfo.detail.name,
                        builder: (BuildContext context, GoRouterState state) {
                          final Map<String, dynamic> extra =
                              state.extra as Map<String, dynamic>;
                          return UserDetailPage(
                              login: extra['login'],
                              avatarUrl: extra['avatarUrl']);
                        },
                      ),
                    ]),
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                  path: '/${RouteInfo.stars.name}',
                  builder: (BuildContext context, GoRouterState state) {
                    return const StarsPage(title: 'Stars');
                  },
                ),
              ]),
            ])
      ]);
}
