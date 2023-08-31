import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/core/widgets/loading.dart';
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart';
import 'package:eth_chat/features/wallet_connect/services/wallet_service.dart';
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

  // Future<void> _initService() async {
  // await _service.init();
  // final _service = WalletConnectModalService(
  //   projectId: '1234',
  //   metadata: const PairingMetadata(
  //     name: 'Flutter WalletConnect',
  //     description: 'Flutter WalletConnectModal Sign Example',
  //     url: 'https://walletconnect.com/',
  //     icons: ['https://walletconnect.com/walletconnect-logo.png'],
  //   ),
  // );
  // await _service.init();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) => state.map(
            (wallet) => Center(
              child: Text(wallet.app.metadata.url),
            ),
            none: (_) => const LoadingWidget(),
          ),
        ),
      );
}
