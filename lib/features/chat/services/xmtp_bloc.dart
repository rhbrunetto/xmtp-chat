import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/chat/services/xmtp/xmtp_isolate.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/utils/processing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';

import 'package:xmtp/xmtp.dart' as xmtp;

typedef XmtpState = ProcessingState<XmtpIsolate>;

class XmtpBloc extends Cubit<XmtpState> {
  XmtpBloc({
    required FlutterSecureStorage storage,
    required xmtp.Api api,
  })  : _storage = storage,
        _api = api,
        super(const XmtpState.loading());

  final FlutterSecureStorage _storage;
  final xmtp.Api _api;

  Future<void> initialize(Session session) => tryEitherAsync(
        (_) async {
          emit(const XmtpState.loading());
          final keys = await _getKeys(session.app, session.sessionData);
          final isolate = await XmtpIsolate.spawn(keys);
          return isolate;
        },
      )
          .letAsync(
            (it) => it.fold(
              (_) => const XmtpState.failed(),
              XmtpState.success,
            ),
          )
          .letAsync(emit);

  Future<xmtp.PrivateKeyBundle> _getKeys(
    Web3App app,
    SessionData session,
  ) async {
    final api = _api;
    final storedKeys = await _storage.readStoredKeys();

    final xmtp.Client client;
    if (storedKeys != null) {
      client = await xmtp.Client.createFromKeys(api, storedKeys);
    } else {
      client = await xmtp.Client.createFromWallet(api, session.asSigner(app));
      await _storage.writeKeys(client.keys);
    }

    return client.keys;
  }
}

extension on SessionData {
  xmtp.Signer asSigner(Web3App app) {
    const chain = 'eip155';
    const chainId = 'eip155:1';
    final namespace = namespaces[chain];
    if (namespace == null) throw Exception();
    final address =
        namespace.accounts.first.split(chainId)[1].replaceAll(':', '');

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
          .then((res) => hexToBytes(res)),
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
