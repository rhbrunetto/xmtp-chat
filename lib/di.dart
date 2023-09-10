import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import 'config.dart';
import 'db/db.dart';
import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
Future<void> configureDependencies() async => sl.init();

@module
abstract class AppModule {
  AppModule();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  final db = MyDatabase.connect();

  @factoryMethod
  xmtp.Api createApi() => xmtp.Api.create(host: xmtpHost, isSecure: true);
}
