import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_stars/bloc/main/main_cubit.dart';
import 'package:flutter_git_stars/bloc/main/main_state.dart';
import 'package:go_router/go_router.dart';

import '../route/router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) =>
      MainCubit()
        ..initState(),
      child: BlocBuilder<MainCubit, MainState>(
          builder: (BuildContext context, MainState state) {
            return Scaffold(
              body: widget.navigationShell,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.currentIndex,
                onTap: (index) {
                  widget.navigationShell.goBranch(index,
                      initialLocation: index ==
                          widget.navigationShell.currentIndex);
                  context.read<MainCubit>().onTabChanged(index);
                },
                items: buildBottomNavigationBarItems(state.tabs),
              ),
            );
          }),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavigationBarItems(
      List<RouteInfo> tabs) {
    List<BottomNavigationBarItem> items = [];
    for (RouteInfo routeInfo in tabs) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(routeInfo.iconData),
          label: routeInfo.title,
        ),
      );
    }
    return items;
  }
}
