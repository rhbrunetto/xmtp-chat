import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/core/widgets/loading.dart';
import 'package:eth_chat/features/session/services/session_cubit.dart';
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

@RoutePage()
class WalletConnectScreen extends StatefulWidget {
  const WalletConnectScreen({super.key});

  @override
  State<WalletConnectScreen> createState() => _State();
}

class _State extends State<WalletConnectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const WalletEvent.initialize());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) => state.map(
              (wallet) => _WalletConnectScreen(
                service: wallet.modalService,
                client: wallet.app,
              ),
              none: (_) => const LoadingWidget(),
            ),
          ),
        ),
      );
}

class _WalletConnectScreen extends StatefulWidget {
  const _WalletConnectScreen({
    required this.service,
    required this.client,
  });

  final WalletConnectModalService service;
  final Web3App client;

  @override
  State<_WalletConnectScreen> createState() => _WalletConnectScreenState();
}

class _WalletConnectScreenState extends State<_WalletConnectScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.service.isConnected) {
      _onConnect(widget.service.session);
    }
    widget.client.onSessionConnect.subscribe((it) => _onConnect(it?.session));
  }

  void _onConnect(SessionData? session) {
    if (session == null) return;
    context.read<SessionCubit>().startSession(widget.client, session);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          WalletConnectModalConnect(
            service: widget.service,
            connectedWidget: const Text('connected'),
          ),
        ],
      );
}
