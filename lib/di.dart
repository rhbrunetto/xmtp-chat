import 'package:eth_chat/config.dart';
import 'package:eth_chat/db/db.dart';
import 'package:eth_chat/di.config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

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
  final xmtp.Api api = xmtp.Api.create(host: xmtpHost, isSecure: true);

  @lazySingleton
  final db = MyDatabase.connect();
}
