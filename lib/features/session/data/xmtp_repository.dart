import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

@injectable
class XmtpRepository {
  XmtpRepository({
    required xmtp.Api api,
    required FlutterSecureStorage storage,
  })  : _storage = storage,
        _api = api;

  final xmtp.Api _api;
  final FlutterSecureStorage _storage;

  Future<xmtp.PrivateKeyBundle> getKeys(
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

  AsyncResult<xmtp.Client> load(Web3App app, SessionData session) =>
      tryEitherAsync(
        (_) async {
          throw Exception();
          // print('OK HERE WE ARE 0');
          // final api = _api;
          // final storedKeys = await _storage.readStoredKeys();
          //
          // print('OK HERE WE ARE 1');
          // final client = await storedKeys
          //     .maybeFlatMap(xmtp.PrivateKeyBundle.fromBuffer)
          //     .maybeFlatMap((keys) => xmtp.Client.createFromKeys(api, keys))
          //     .ifNull(() {
          //   final signer = session.asSigner(app);
          //   return xmtp.Client.createFromWallet(api, signer);
          // });
          //
          // print('OK HERE WE ARE 2');
          //
          // await _storage.writeKeys(client.keys.writeToBuffer());
          //
          // return client;
        },
      );
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
