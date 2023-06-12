import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_git_stars/data/remote/users_remote_data_source.dart';
import 'package:flutter_git_stars/data/utils/custom_http_client.dart';
import 'package:flutter_git_stars/data/utils/custom_json_decoder.dart';
import 'package:flutter_git_stars/domain/entity/user_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

import 'users_remote_data_source_test.mocks.dart';

class HttpClientTest extends Mock implements CustomHttpClient {}

class JsonDecoderTest extends Mock implements CustomJsonDecoder {}

@GenerateMocks(<Type>[HttpClientTest, JsonDecoderTest])
void main() {
  late CustomHttpClient mockHttpClient;
  late CustomJsonDecoder mockJsonDecoder;
  late UsersRemoteDataSource usersRemoteDataSource;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    mockHttpClient = MockHttpClientTest();
    mockJsonDecoder = MockJsonDecoderTest();
    usersRemoteDataSource =
        UsersRemoteDataSourceImpl(mockHttpClient, mockJsonDecoder);
  });

  group('fetchUsers', () {
    test('the request succeeds', () async {
      // given
      const String login = 'test_id';
      final Uri uri = Uri.https('api.github.com', '/users/$login');
      final Response response = Response('', 200);
      final UserInfoModel userInfoModel = UserInfoModel(
          name: 'name',
          email: '',
          createdAt: '1234',
          updatedAt: '',
          followers: '',
          following: '');

      // when
      when(mockHttpClient.get(uri)).thenAnswer((_) async {
        return response;
      });
      when(mockJsonDecoder.convert(utf8.decode(response.bodyBytes)))
          .thenReturn(userInfoModel.toJson());

      // then
      expect((await usersRemoteDataSource.fetchUserInfo(login)).name,
          userInfoModel.name);
      expect((await usersRemoteDataSource.fetchUserInfo(login)).email,
          userInfoModel.email);
      expect((await usersRemoteDataSource.fetchUserInfo(login)).createdAt,
          userInfoModel.createdAt);
    });
  });
}
