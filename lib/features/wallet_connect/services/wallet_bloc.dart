import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

part 'wallet_bloc.freezed.dart';

typedef _Event = WalletEvent;
typedef _State = WalletState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@freezed
class WalletState with _$WalletState {
  const factory WalletState.none() = _None;

  const factory WalletState({
    required Web3App app,
    @Default(true) bool isProcessing,
  }) = _WalletState;
}

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.initialize() = _Initialize;
  const factory WalletEvent.connect() = _Connect;
}

@injectable
class WalletBloc extends Bloc<_Event, _State> {
  WalletBloc() : super(const WalletState.none()) {
    on<_Event>(_handler);
  }

  _EventHandler get _handler => (event, emit) => event.map(
        initialize: (e) => _onInitialize(emit),
        connect: (e) => _onConnect(e, emit),
      );

  Future<void> _onInitialize(_Emitter emit) async {
    final client = await Web3App.createInstance(
      relayUrl:
          'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: '123',
      metadata: const PairingMetadata(
        name: 'dApp (Requester)',
        description: 'A dapp that can request that transactions be signed',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );

    emit(
      WalletState(app: client, isProcessing: false),
    );
  }

  Future<void> _onConnect(_Connect e, _Emitter emit) async {}
}
