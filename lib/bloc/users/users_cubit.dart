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
    final SearchResponse response = await _usersUseCase.searchUsers(
        query, state.sortType, state.orderType, 1, 10);
    final List<UserItemModel> users = response.items;
    emit(state.copyWith(users: users, query: query, page: 1));
  }

  void loadMoreUsers() async {
    final int nextPage = state.page + 1;
    final SearchResponse response = await _usersUseCase.searchUsers(
        state.query, state.sortType, state.orderType, nextPage, state.perPage);
    final List<UserItemModel> users = response.items;

    if (response.items.isEmpty) {
      return;
    }
    emit(state.copyWith(
        users: state.users + users, page: nextPage));
  }
}
