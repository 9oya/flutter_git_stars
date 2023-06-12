// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:convert' as _i5;

import 'package:flutter_git_stars/data/remote/users_remote_data_source.dart'
    as _i7;
import 'package:flutter_git_stars/data/repository/users_repository.dart' as _i8;
import 'package:flutter_git_stars/data/utils/custom_http_client.dart' as _i4;
import 'package:flutter_git_stars/data/utils/custom_json_decoder.dart' as _i6;
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.Client>(() => _i4.CustomHttpClient());
    gh.factory<_i5.Converter<dynamic, dynamic>>(() => _i6.CustomJsonDecoder());
    gh.factory<_i7.UsersRemoteDataSource>(() => _i7.UsersRemoteDataSourceImpl(
          gh<_i3.Client>(),
          gh<_i5.Converter<dynamic, dynamic>>(),
        ));
    gh.factory<_i8.UsersRepository>(
        () => _i8.UsersRepositoryImpl(gh<_i7.UsersRemoteDataSource>()));
    gh.factory<_i9.UsersUseCase>(
        () => _i9.UsersUseCaseImpl(gh<_i8.UsersRepository>()));
    return this;
  }
}
