
import 'package:flutter_git_stars/presentation/utils/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)
GetIt configureDependencies() {
  return getIt.init();
}