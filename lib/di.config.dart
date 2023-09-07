// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eth_chat/db/db.dart' as _i3;
import 'package:eth_chat/features/chat/data/chat_repository.dart' as _i6;
import 'package:eth_chat/features/chat/services/chat_service.dart' as _i7;
import 'package:eth_chat/features/chat/services/chat_watcher.dart' as _i8;
import 'package:eth_chat/features/chat/services/convo_service.dart' as _i9;
import 'package:eth_chat/features/session/services/session_cubit.dart' as _i4;
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart'
    as _i5;
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
    gh.lazySingleton<_i3.MyDatabase>(() => _i3.MyDatabase());
    gh.factory<_i4.SessionCubit>(() => _i4.SessionCubit());
    gh.factory<_i5.WalletBloc>(() => _i5.WalletBloc());
    gh.factory<_i6.ChatRepository>(
        () => _i6.ChatRepository(gh<_i3.MyDatabase>()));
    gh.factoryParam<_i7.ChatService, String, dynamic>((
      sender,
      _,
    ) =>
        _i7.ChatService(
          sender: sender,
          repository: gh<_i6.ChatRepository>(),
        ));
    gh.factory<_i8.ChatWatcher>(
        () => _i8.ChatWatcher(repository: gh<_i6.ChatRepository>()));
    gh.factoryParam<_i9.ConvoService, String, String>((
      sender,
      recipient,
    ) =>
        _i9.ConvoService(
          sender: sender,
          recipient: recipient,
          repository: gh<_i6.ChatRepository>(),
        ));
    return this;
  }
}
