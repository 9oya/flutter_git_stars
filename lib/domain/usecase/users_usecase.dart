import 'package:injectable/injectable.dart';

import '../../data/remote/users_remote_data_source.dart';
import '../../data/repository/users_repository.dart';
import '../entity/entity.dart';

abstract class UsersUseCase {
  Future<UserInfoModel> fetchUserInfo(String login);

  Future<SearchResponse> searchUsers(
      String query, UserSortType sort, OrderType order, int page, int perPage);
}

@Injectable(as: UsersUseCase)
class UsersUseCaseImpl implements UsersUseCase {
  UsersUseCaseImpl(this._usersRepository);

  final UsersRepository _usersRepository;

  @override
  Future<UserInfoModel> fetchUserInfo(String login) {
    return _usersRepository.fetchUserInfo(login);
  }

  @override
  Future<SearchResponse> searchUsers(String query, UserSortType sort,
      OrderType order, int page, int perPage) async {
    return await _usersRepository.searchUsers(
        query, sort, order, page, perPage);
  }
}
