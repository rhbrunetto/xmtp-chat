// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eth_chat/db/db.dart' as _i5;
import 'package:eth_chat/di.dart' as _i13;
import 'package:eth_chat/features/chat/data/convo_repository.dart' as _i8;
import 'package:eth_chat/features/chat/data/message_repository.dart' as _i9;
import 'package:eth_chat/features/chat/services/chat_service.dart' as _i11;
import 'package:eth_chat/features/chat/services/xmtp/xmtp_isolate.dart' as _i12;
import 'package:eth_chat/features/session/data/xmtp_repository.dart' as _i7;
import 'package:eth_chat/features/session/services/session_cubit.dart' as _i10;
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart'
    as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:xmtp/xmtp.dart' as _i3;

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
    gh.factory<_i3.Api>(() => appModule.api);
    gh.lazySingleton<_i4.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i5.MyDatabase>(() => _i5.MyDatabase());
    gh.factory<_i6.WalletBloc>(() => _i6.WalletBloc());
    gh.factory<_i7.XmtpRepository>(() => _i7.XmtpRepository(
          api: gh<_i3.Api>(),
          storage: gh<_i4.FlutterSecureStorage>(),
        ));
    gh.factory<_i8.ConvoRepository>(
        () => _i8.ConvoRepository(gh<_i5.MyDatabase>()));
    gh.factory<_i9.MessageRepository>(
        () => _i9.MessageRepository(gh<_i5.MyDatabase>()));
    gh.factory<_i10.SessionCubit>(
        () => _i10.SessionCubit(repository: gh<_i7.XmtpRepository>()));
    gh.factoryParam<_i11.ChatService, _i12.XmtpIsolate, dynamic>((
      isolate,
      _,
    ) =>
        _i11.ChatService(
          isolate: isolate,
          messageRepository: gh<_i9.MessageRepository>(),
          convoRepository: gh<_i8.ConvoRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i13.AppModule {}
