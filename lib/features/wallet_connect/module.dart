import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/wallet_connect/services/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class WalletConnectModule extends SingleChildStatelessWidget {
  const WalletConnectModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => sl<WalletBloc>(),
        child: child,
      );
}
