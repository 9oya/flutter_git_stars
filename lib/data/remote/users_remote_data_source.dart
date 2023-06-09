import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/entity.dart';

enum UserSortType {
  repos('repositories'),
  followers('followers'),
  joined('joined'),
  bestMatch('');

  const UserSortType(this.value);

  final String value;
}

enum OrderType {
  desc('desc'),
  asc('asc');

  const OrderType(this.value);

  final String value;
}

abstract class UsersRemoteDataSource {
  Future<UserInfoModel> fetchUserInfo(String login);

  Future<SearchResponse> searchUsers(
      String query, UserSortType sort, OrderType order, int page, int perPage);
}

@Injectable(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  @override
  Future<UserInfoModel> fetchUserInfo(String login) {
    final http.Client client = http.Client();
    return client
        .get(Uri.https('api.github.com', '/users/$login'))
        .then((Response response) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return UserInfoModel.fromJson(decodedResponse);
    }).whenComplete(() => client.close());
  }

  @override
  Future<SearchResponse> searchUsers(String query, UserSortType sort,
      OrderType order, int page, int perPage) async {
    final http.Client client = http.Client();
    try {
      Response response =
          await client.get(Uri.https('api.github.com', '/search/users', {
        'q': query,
        'sort': sort.value,
        'order': order.value,
        'page': page.toString(),
        'per_page': perPage.toString(),
      }));
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      SearchResponse searchResponse = SearchResponse.fromJson(decodedResponse);
      return searchResponse;
    } finally {
      client.close();
    }
  }
}
