import 'package:bloc/bloc.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.fromDefault());

  void initState() {
    emit(MainState.fromDefault());
  }

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
