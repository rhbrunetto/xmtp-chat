import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import '../../../utils/processing_state.dart';
import '../../session/data/session.dart';
import 'xmtp/xmtp_isolate.dart';

typedef XmtpPair = ({XmtpIsolate isolate, xmtp.Client client});
typedef XmtpState = ProcessingState<XmtpPair>;

@injectable
class XmtpBloc extends Cubit<XmtpState> {
  XmtpBloc({
    required FlutterSecureStorage storage,
    required xmtp.Api api,
  })  : _storage = storage,
        _api = api,
        super(const XmtpState.loading());

  final FlutterSecureStorage _storage;
  final xmtp.Api _api;

  Future<void> initializeIsolate(Session session) => tryEitherAsync(
        (_) async {
          emit(const XmtpState.loading());
          final client = await _getClient(session);
          final isolate = await XmtpIsolate.spawn(client.keys);
          return (isolate: isolate, client: client);
        },
      )
          .letAsync(
            (it) => it.fold(
              (_) => const XmtpState.failed(),
              XmtpState.success,
            ),
          )
          .letAsync(emit);

  Future<void> disconnect() async {
    await state.whenOrNull(
      success: (pair) async {
        await pair.isolate.kill();
        await pair.client.terminate();
      },
    );
    await _storage.delete(key: _key);
  }

  @override
  Future<void> close() async {
    await disconnect();
    await super.close();
  }

  Future<xmtp.Client> _getClient(Session session) async {
    final app = session.app;
    final data = session.sessionData;

    final storedKeys = await _storage.readStoredKeys();

    final xmtp.Client client;
    if (storedKeys != null) {
      client = await xmtp.Client.createFromKeys(_api, storedKeys);
    } else {
      session.openWallet().ignore();
      client = await xmtp.Client.createFromWallet(_api, data.asSigner(app));
      await _storage.writeKeys(client.keys);
    }

    return client;
  }
}

extension on SessionData {
  xmtp.Signer asSigner(Web3App app) {
    // TODO(rhbrunetto): Remove hardcoded chain
    const chain = 'eip155';
    const chainId = 'eip155:1';
    final namespace = namespaces[chain];
    if (namespace == null) throw Exception();
    final address = NamespaceUtils.getAccount(namespace.accounts.first);

    return xmtp.Signer.create(
      address,
      (text) => app
          .request(
            topic: topic,
            chainId: chainId,
            request: SessionRequestParams(
              method: 'personal_sign',
              params: [text, address],
            ),
          )
          // ignore: unnecessary_lambdas, can't cast
          .then((it) => hexToBytes(it)),
    );
  }
}

extension on FlutterSecureStorage {
  Future<xmtp.PrivateKeyBundle?> readStoredKeys() async => read(key: _key)
      .letAsync((it) => it.maybeFlatMap(xmtp.PrivateKeyBundle.fromJson));

  Future<void> writeKeys(xmtp.PrivateKeyBundle keys) async =>
      write(key: _key, value: keys.writeToJson());
}

const _key = 'xmtp_keys';
