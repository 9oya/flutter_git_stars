import 'package:equatable/equatable.dart';
import 'package:flutter_git_stars/domain/entity/entity.dart';

class UserDetailState extends Equatable {
  const UserDetailState({
    required this.avatarUrl,
    required this.login,
    required this.userInfo,
  });

  final String avatarUrl;
  final String login;
  final UserInfoModel? userInfo;

  factory UserDetailState.fromDefault() {
    return const UserDetailState(
      avatarUrl: '',
      login: '',
      userInfo: null,
    );
  }

  UserDetailState copyWith({
    String? avatarUrl,
    String? login,
    UserInfoModel? userInfo,
  }) {
    return UserDetailState(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      login: login ?? this.login,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props => [
        avatarUrl,
        login,
        userInfo,
      ];
}
