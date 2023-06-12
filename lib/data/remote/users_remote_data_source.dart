import 'dart:convert';

import 'package:http/http.dart' as http;
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
  UsersRemoteDataSourceImpl(this._client, this._decoder);

  final http.Client _client;
  final Converter _decoder;

  @override
  Future<UserInfoModel> fetchUserInfo(String login) {
    return _client
        .get(Uri.https('api.github.com', '/users/$login'))
        .then((http.Response response) {
      var decodedResponse = _decoder.convert(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
      return UserInfoModel.fromJson(decodedResponse);
    }).whenComplete(() {});
  }

  @override
  Future<SearchResponse> searchUsers(String query, UserSortType sort,
      OrderType order, int page, int perPage) async {
    try {
      http.Response response =
          await _client.get(Uri.https('api.github.com', '/search/users', {
        'q': query,
        'sort': sort.value,
        'order': order.value,
        'page': page.toString(),
        'per_page': perPage.toString(),
      }));
      var decodedResponse = _decoder.convert(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
      SearchResponse searchResponse = SearchResponse.fromJson(decodedResponse);
      return searchResponse;
    } finally {}
  }
}
