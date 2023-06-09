import 'package:equatable/equatable.dart';

import '../../domain/entity/user_item_model.dart';

class UsersState extends Equatable {
  const UsersState({required this.users});

  final List<UserItemModel> users;

  factory UsersState.fromDefault() {
    return const UsersState(users: []);
  }

  UsersState copyWith({
    List<UserItemModel>? users,
  }) {
    return UsersState(
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [
        users,
      ];
}
