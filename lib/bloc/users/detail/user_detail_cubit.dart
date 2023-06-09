import 'package:bloc/bloc.dart';
import 'package:flutter_git_stars/bloc/users/detail/user_detail_state.dart';
import 'package:flutter_git_stars/domain/entity/entity.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._usersUseCase) : super(UserDetailState.fromDefault());

  final UsersUseCase _usersUseCase;

  void initState(String login, String avatarUrl) {
    emit(state.copyWith(
      login: login,
      avatarUrl: avatarUrl,
    ));
  }

  void getUserDetail(String login) async {
    final UserInfoModel userInfo = await _usersUseCase.fetchUserInfo(login);
    emit(state.copyWith(userInfo: userInfo));
  }
}
