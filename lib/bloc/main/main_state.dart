import 'package:equatable/equatable.dart';

import '../../presentation/route/router.dart';

class MainState extends Equatable {
  const MainState({
    required this.tabs,
    required this.currentIndex,
  });

  final List<RouteInfo> tabs;
  final int currentIndex;

  factory MainState.fromDefault() {
    return const MainState(tabs: [RouteInfo.users, RouteInfo.stars], currentIndex: 0);
  }

  MainState copyWith({
    List<RouteInfo>? tabs,
    int? currentIndex,
  }) {
    return MainState(
      tabs: tabs ?? this.tabs,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [tabs, currentIndex];
}
