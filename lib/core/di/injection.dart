import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

abstract final class Env {
  static const dev = 'dev';
  static const staging = 'staging';
  static const prod = 'prod';
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies(String env) => getIt.init(environment: env);
