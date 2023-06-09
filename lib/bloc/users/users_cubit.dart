import 'package:bloc/bloc.dart';
import 'package:flutter_git_stars/bloc/users/users_state.dart';
import 'package:flutter_git_stars/data/remote/users_remote_data_source.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';

import '../../domain/entity/entity.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usersUseCase) : super(UsersState.fromDefault());

  final UsersUseCase _usersUseCase;

  void initState() {
    emit(UsersState.fromDefault());
  }

  void searchUsers(String query) async {
    final SearchResponse response = await _usersUseCase.searchUsers(
        query, UserSortType.followers, OrderType.desc, 1, 10);
    final List<UserItemModel> users = response.items;
    emit(state.copyWith(users: users));
  }
}
