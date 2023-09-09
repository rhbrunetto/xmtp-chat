import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

import '../../../config.dart';

part 'wallet_bloc.freezed.dart';

typedef _Event = WalletEvent;
typedef _State = WalletState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    required Web3App app,
    required WalletConnectModalService modalService,
    @Default(true) bool isProcessing,
  }) = _WalletState;
  const factory WalletState.none() = _None;
}

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.initialize() = _Initialize;
}

@injectable
class WalletBloc extends Bloc<_Event, _State> {
  WalletBloc() : super(const WalletState.none()) {
    on<_Event>(_handler);
  }

  _EventHandler get _handler => (event, emit) => event.map(
        initialize: (e) => _onInitialize(emit),
      );

  Future<void> _onInitialize(_Emitter emit) async {
    final web3App = await Web3App.createInstance(
      projectId: projectId,
      metadata: const PairingMetadata(
        name: 'dApp (Requester)',
        description: 'A dapp that can request that transactions be signed',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
        redirect: Redirect(native: 'flutterdap://', universal: 'flutterdap://'),
      ),
    );

    final service = WalletConnectModalService(
      web3App: web3App,
      requiredNamespaces: const {
        'eip155': RequiredNamespace(
          chains: ['eip155:1'], // Ethereum chain
          methods: [
            'personal_sign',
            'eth_signTypedData',
            'eth_sendTransaction',
            'wallet_switchEthereumChain',
            'wallet_addEthereumChain',
          ], // Requestable Methods
          events: [
            'chainChanged',
            'accountsChanged',
          ], // Requestable Events
        ),
      },
      recommendedWalletIds: {
        'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
        '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // Trust
      },
    );

    await service.init();

    emit(
      WalletState(
        app: web3App,
        modalService: service,
        isProcessing: false,
      ),
    );
  }
}
