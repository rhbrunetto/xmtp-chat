import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/data/xmtp_repository.dart';
import 'package:eth_chat/utils/processing_state.dart';
import 'package:injectable/injectable.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

typedef SessionState = ProcessingState<Session>;

@injectable
class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required XmtpRepository repository,
  })  : _repository = repository,
        super(const SessionState.failed());

  final XmtpRepository _repository;

  Future<void> startSession(Web3App app, SessionData session) async {
    // final response = await _repository.load(app, session);

    // final newState = response.fold(
    //   (_) => const SessionState.failed(),
    //   (client) => Session(
    //     app: app,
    //     sessionData: session,
    //   ).let(SessionState.success),
    // );
    // print(newState);
    emit(Session(app: app, sessionData: session).let(SessionState.success));
  }

  void disconnect() {
    final session = state.whenOrNull(success: identity);
    if (session == null) return;

    session.app.core.pairing.disconnect(
      topic: session.sessionData.pairingTopic,
    );

    emit(const SessionState.failed());
  }
}
