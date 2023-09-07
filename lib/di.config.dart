// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eth_chat/db/db.dart' as _i4;
import 'package:eth_chat/di.dart' as _i12;
import 'package:eth_chat/features/chat/data/chat_repository.dart' as _i8;
import 'package:eth_chat/features/chat/services/chat_service.dart' as _i9;
import 'package:eth_chat/features/chat/services/chat_watcher.dart' as _i10;
import 'package:eth_chat/features/chat/services/convo_service.dart' as _i11;
import 'package:eth_chat/features/session/services/session_cubit.dart' as _i5;
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart'
    as _i6;
import 'package:eth_chat/features/xmtp/services/xmtp_service.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
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
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i4.MyDatabase>(() => _i4.MyDatabase());
    gh.factory<_i5.SessionCubit>(() => _i5.SessionCubit());
    gh.factory<_i6.WalletBloc>(() => _i6.WalletBloc());
    gh.factory<_i7.XmtpService>(
        () => _i7.XmtpService(storage: gh<_i3.FlutterSecureStorage>()));
    gh.factory<_i8.ChatRepository>(
        () => _i8.ChatRepository(gh<_i4.MyDatabase>()));
    gh.factoryParam<_i9.ChatService, String, dynamic>((
      sender,
      _,
    ) =>
        _i9.ChatService(
          sender: sender,
          repository: gh<_i8.ChatRepository>(),
        ));
    gh.factory<_i10.ChatWatcher>(
        () => _i10.ChatWatcher(repository: gh<_i8.ChatRepository>()));
    gh.factoryParam<_i11.ConvoService, String, String>((
      sender,
      recipient,
    ) =>
        _i11.ConvoService(
          sender: sender,
          recipient: recipient,
          repository: gh<_i8.ChatRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}
