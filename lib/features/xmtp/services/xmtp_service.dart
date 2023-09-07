import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

@injectable
class XmtpService {
  XmtpService({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  final FlutterSecureStorage _storage;

  xmtp.Client? client;

  Future<void> initialize(Session session) async {
    final api = xmtp.Api.create();
    final storedKeys = await _storage.readStoredKeys();
    final client = await storedKeys
        .maybeFlatMap(xmtp.PrivateKeyBundle.fromBuffer)
        .maybeFlatMap((keys) => xmtp.Client.createFromKeys(api, keys))
        .ifNull(() => xmtp.Client.createFromWallet(api, session.asSigner()));

    await _storage.writeKeys(client.keys.writeToBuffer());
  }
}

extension on Session {
  xmtp.Signer asSigner() {
    final x = sessionData.namespaces;
    print(x);
    const chain = 'eip155';
    const chainId = 'eip155:1';
    final namespace = sessionData.namespaces[chain];
    if (namespace == null) throw Exception();
    final address =
        namespace.accounts.first.split(chainId)[1].replaceAll(':', '');

    return xmtp.Signer.create(
      address,
      (text) => app
          .request(
        topic: sessionData.topic,
        chainId: chainId,
        request: SessionRequestParams(
          method: "personal_sign",
          params: [text, address],
        ),
      )
          .then((res) {
        print(res);
        return hexToBytes(res);
      }),
    );
  }
}

extension on FlutterSecureStorage {
  Future<List<int>?> readStoredKeys() async => null;

  Future<void> writeKeys(Uint8List keys) async {}
}

const _key = 'xmtp_keys';
