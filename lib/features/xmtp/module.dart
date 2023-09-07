import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/xmtp/services/xmtp_service.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class XmtpModule extends SingleChildStatelessWidget {
  const XmtpModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => Provider(
        lazy: false,
        create: (context) =>
            sl<XmtpService>()..initialize(context.read<Session>()),
        child: child,
      );
}
