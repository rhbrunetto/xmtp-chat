// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eth_chat/db/db.dart' as _i5;
import 'package:eth_chat/di.dart' as _i15;
import 'package:eth_chat/features/chat/data/convo_repository.dart' as _i9;
import 'package:eth_chat/features/chat/data/message_repository.dart' as _i10;
import 'package:eth_chat/features/chat/services/chat_service.dart' as _i13;
import 'package:eth_chat/features/chat/services/xmtp/xmtp_isolate.dart' as _i14;
import 'package:eth_chat/features/chat/services/xmtp/xmtp_receiver.dart'
    as _i11;
import 'package:eth_chat/features/chat/services/xmtp/xmtp_sender.dart' as _i12;
import 'package:eth_chat/features/chat/services/xmtp_bloc.dart' as _i8;
import 'package:eth_chat/features/session/services/session_cubit.dart' as _i6;
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart'
    as _i7;
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
    gh.factory<_i3.Api>(() => appModule.createApi());
    gh.lazySingleton<_i4.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.factory<_i5.MyDatabase>(() => appModule.db);
    gh.factory<_i6.SessionCubit>(() => _i6.SessionCubit());
    gh.factory<_i7.WalletBloc>(() => _i7.WalletBloc());
    gh.factory<_i8.XmtpBloc>(() => _i8.XmtpBloc(
          storage: gh<_i4.FlutterSecureStorage>(),
          api: gh<_i3.Api>(),
        ));
    gh.factory<_i9.ConvoRepository>(
        () => _i9.ConvoRepository(gh<_i5.MyDatabase>()));
    gh.factory<_i10.MessageRepository>(
        () => _i10.MessageRepository(gh<_i5.MyDatabase>()));
    gh.factoryParam<_i11.XmtpReceiver, _i3.Client, dynamic>((
      client,
      _,
    ) =>
        _i11.XmtpReceiver(
          client: client,
          convoRepository: gh<_i9.ConvoRepository>(),
          messageRepository: gh<_i10.MessageRepository>(),
        ));
    gh.factoryParam<_i12.XmtpSender, _i3.Client, dynamic>((
      client,
      _,
    ) =>
        _i12.XmtpSender(
          client: client,
          convoRepository: gh<_i9.ConvoRepository>(),
          messageRepository: gh<_i10.MessageRepository>(),
        ));
    gh.factoryParam<_i13.ChatService, _i14.XmtpIsolate, dynamic>((
      isolate,
      _,
    ) =>
        _i13.ChatService(
          isolate: isolate,
          messageRepository: gh<_i10.MessageRepository>(),
          convoRepository: gh<_i9.ConvoRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
