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

typedef XmtpState = ProcessingState<XmtpIsolate>;

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
          final keys = await _getKeys(session);
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

  Future<void> disconnect() => _storage.delete(key: _key);

  @override
  Future<void> close() async {
    await state.whenOrNull(success: (it) => it.kill());
    await super.close();
  }

  Future<xmtp.PrivateKeyBundle> _getKeys(Session session) async {
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

    return client.keys;
  }
}

extension on SessionData {
  // TODO(rhbrunetto): For some reason, app.request is not launching wallet app
  xmtp.Signer asSigner(Web3App app) {
    // TODO(rhbrunetto): Remove hardcoded chain
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
