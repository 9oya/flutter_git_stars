import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_stars/bloc/main/main_cubit.dart';
import 'package:flutter_git_stars/bloc/main/main_state.dart';
import 'package:go_router/go_router.dart';

import '../route/router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..initState(),
      child: BlocBuilder<MainCubit, MainState>(
          builder: (BuildContext context, MainState state) {
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go(Routes.users.path,
                      extra: {'title': Routes.users.title});
                  break;
                case 1:
                  context.go(Routes.stars.path,
                      extra: {'title': Routes.stars.title});
                  break;
              }

              context.read<MainCubit>().changeTab(index);
            },
            items: buildBottomNavigationBarItems(state.tabs),
          ),
        );
      }),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavigationBarItems(
      List<Routes> tabs) {
    List<BottomNavigationBarItem> items = [];
    for (Routes routes in tabs) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(routes.iconData),
          label: routes.title,
        ),
      );
    }
    return items;
  }
}
