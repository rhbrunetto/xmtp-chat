import 'package:eth_chat/di.config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
Future<void> configureDependencies() async => sl.init();

@module
abstract class AppModule {
  const AppModule();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
