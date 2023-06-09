// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_git_stars/data/remote/users_remote_data_source.dart'
    as _i3;
import 'package:flutter_git_stars/data/repository/users_repository.dart' as _i4;
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
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
    gh.factory<_i3.UsersRemoteDataSource>(
        () => _i3.UsersRemoteDataSourceImpl());
    gh.factory<_i4.UsersRepository>(
        () => _i4.UsersRepositoryImpl(gh<_i3.UsersRemoteDataSource>()));
    gh.factory<_i5.UsersUseCase>(
        () => _i5.UsersUseCaseImpl(gh<_i4.UsersRepository>()));
    return this;
  }
}
