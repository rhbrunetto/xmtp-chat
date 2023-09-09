import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import 'services/wallet_bloc.dart';

class WalletConnectModule extends SingleChildStatelessWidget {
  const WalletConnectModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => sl<WalletBloc>(),
        child: child,
      );
}
