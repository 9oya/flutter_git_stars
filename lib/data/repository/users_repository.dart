import 'package:flutter_git_stars/data/remote/users_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/entity.dart';

abstract class UsersRepository {
  Future<UserInfoModel> fetchUserInfo(String login);

  Future<SearchResponse> searchUsers(String query, UserSortType sort,
      OrderType order, int page, int perPage);
}

@Injectable(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._usersRemoteDataSource);

  final UsersRemoteDataSource _usersRemoteDataSource;

  @override
  Future<UserInfoModel> fetchUserInfo(String login) {
    return _usersRemoteDataSource.fetchUserInfo(login);
  }

  @override
  Future<SearchResponse> searchUsers(String query, UserSortType sort,
      OrderType order, int page, int perPage) async {
    return await _usersRemoteDataSource.searchUsers(
        query, sort, order, page, perPage);
  }
}
