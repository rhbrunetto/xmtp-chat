import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/utils/processing_state.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

typedef SessionState = ProcessingState<Session>;

@injectable
class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState.failed());

  void startSession(Web3App client, SessionData session) => emit(
        Session(app: client, sessionData: session).let(SessionState.success),
      );
}
