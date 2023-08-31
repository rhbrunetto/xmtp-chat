import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletService {
  Web3App? _wcClient;
  SessionData? _session;

  Future<void> initalize() async {
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
    final response = await client.connect(requiredNamespaces: {
      'eip155': const RequiredNamespace(
        chains: ['eip155:1'], // Ethereum chain
        methods: ['eth_signTransaction'], // Requestable Methods
        events: ['eth_sendTransaction'], // Requestable Events
      ),
    });

    // Once you've display the URI, you can wait for the future, and hide the QR code once you've received session data
    _session = await response.session.future;
    _wcClient = client;

    // session.

// Now that you have a session, you can request signatures
    //   final signResponse = await client.request(
    //     topic: session.topic,
    //     chainId: 'eip155:1',
    //     request: const SessionRequestParams(
    //       method: 'eth_signTransaction',
    //       params: 'json serializable parameters',
    //     ),
    //   );
    // }
  }

  Future<void> sign(String topic, dynamic parameters) async {}

  Future<void> stop() async {}
}
