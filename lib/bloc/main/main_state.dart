import 'package:equatable/equatable.dart';

import '../../presentation/route/router.dart';

class MainState extends Equatable {
  const MainState({
    required this.tabs,
    required this.currentIndex,
  });

  final List<Routes> tabs;
  final int currentIndex;

  factory MainState.fromDefault() {
    return const MainState(tabs: [Routes.users, Routes.stars], currentIndex: 0);
  }

  MainState copyWith({
    List<Routes>? tabs,
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
