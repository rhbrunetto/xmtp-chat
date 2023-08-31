import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

class WalletConnectScreen extends StatefulWidget {
  const WalletConnectScreen({super.key});

  @override
  State<WalletConnectScreen> createState() => _State();
}

class _State extends State<WalletConnectScreen> {
  WalletConnectModalService? _service;

  @override
  void initState() {}

  Future<void> _initService() async {
    final _service = WalletConnectModalService(
      projectId: '1234',
      metadata: const PairingMetadata(
        name: 'Flutter WalletConnect',
        description: 'Flutter WalletConnectModal Sign Example',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );
    await _service.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
