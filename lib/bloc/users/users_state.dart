import 'package:equatable/equatable.dart';

import '../../data/remote/users_remote_data_source.dart';
import '../../domain/entity/user_item_model.dart';

class UsersState extends Equatable {
  const UsersState(
      {required this.users,
      required this.perPage,
      required this.page,
      required this.sortType,
      required this.orderType,
      required this.query});

  final List<UserItemModel> users;
  final int perPage;
  final int page;
  final UserSortType sortType;
  final OrderType orderType;
  final String query;

  factory UsersState.fromDefault() {
    return const UsersState(
        users: [],
        perPage: 10,
        page: 1,
        sortType: UserSortType.followers,
        orderType: OrderType.desc,
        query: '');
  }

  UsersState copyWith({
    List<UserItemModel>? users,
    int? perPage,
    int? page,
    UserSortType? sortType,
    OrderType? orderType,
    String? query,
  }) {
    return UsersState(
      users: users ?? this.users,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      sortType: sortType ?? this.sortType,
      orderType: orderType ?? this.orderType,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        users,
        perPage,
        page,
        sortType,
        orderType,
        query,
      ];
}
