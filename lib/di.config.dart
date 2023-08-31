// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eth_chat/db/db.dart' as _i4;
import 'package:eth_chat/features/account/services/account_bloc.dart' as _i3;
import 'package:eth_chat/features/chat/data/chat_repository.dart' as _i5;
import 'package:eth_chat/features/chat/services/convo_service.dart' as _i6;
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
    gh.factory<_i3.AccountBloc>(() => _i3.AccountBloc());
    gh.lazySingleton<_i4.MyDatabase>(() => _i4.MyDatabase());
    gh.factory<_i5.ChatRepository>(
        () => _i5.ChatRepository(gh<_i4.MyDatabase>()));
    gh.factoryParam<_i6.ConvoService, String, String>((
      sender,
      recipient,
    ) =>
        _i6.ConvoService(
          sender: sender,
          recipient: recipient,
          repository: gh<_i5.ChatRepository>(),
        ));
    return this;
  }
}
