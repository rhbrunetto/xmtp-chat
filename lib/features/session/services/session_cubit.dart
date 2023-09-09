import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

import '../../../utils/processing_state.dart';
import '../data/session.dart';

typedef SessionState = ProcessingState<Session>;

@injectable
class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState.failed());

  void startSession(
    Web3App app,
    SessionData session,
    WalletConnectModalService service,
  ) =>
      emit(
        Session(
          app: app,
          sessionData: session,
          modalService: service,
        ).let(SessionState.success),
      );

  void disconnect() {
    final session = state.whenOrNull(success: identity);
    if (session == null) return;

    session.app.core.pairing.disconnect(
      topic: session.sessionData.pairingTopic,
    );

    emit(const SessionState.failed());
  }
}
