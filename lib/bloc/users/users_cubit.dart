import 'package:bloc/bloc.dart';
import 'package:flutter_git_stars/bloc/users/users_state.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';

import '../../domain/entity/entity.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usersUseCase) : super(UsersState.fromDefault());

  final UsersUseCase _usersUseCase;

  void initState() {
    emit(UsersState.fromDefault());
  }

  void searchUsers(String query) async {
    if (query.isNotEmpty && query == state.query) {
      return;
    }
    emit(state.copyWith(isScrollToLoading: true));

    final SearchResponse response = await _usersUseCase.searchUsers(
        query, state.sortType, state.orderType, 1, 10);
    final List<UserItemModel> users = response.items;
    emit(state.copyWith(
        users: users, query: query, page: 1));
  }

  void loadMoreUsers() async {
    emit(state.copyWith(isScrollToLoading: true));

    final int nextPage = state.page + 1;
    final SearchResponse response = await _usersUseCase.searchUsers(state.query,
        state.sortType, state.orderType, nextPage, state.perPage);
    final List<UserItemModel> users = response.items;
    emit(state.copyWith(
        users: state.users + users,
        page: nextPage));
  }

  void scrollToLoadCompleted() {
    emit(state.copyWith(isScrollToLoading: false));
  }
}
