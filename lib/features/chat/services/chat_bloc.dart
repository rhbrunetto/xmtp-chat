import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/chat/data/chat.dart';
import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'chat_bloc.freezed.dart';

typedef _Event = ChatEvent;
typedef _State = ChatState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@freezed
class ChatState with _$ChatState {
  const factory ChatState.none() = _None;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.chats(IList<Chat> chats) = _Chats;
}

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.refresh() = _Refresh;
  const factory ChatEvent.newChat(String recipient) = _New;
}

@injectable
class ChatBloc extends Bloc<_Event, _State> {
  ChatBloc({
    @factoryParam required Session session,
    required ChatRepository repository,
  })  : _repository = repository,
        _session = session,
        super(const ChatState.none()) {
    on<_Event>(
      _handler,
      transformer: (events, mapper) => sequential<ChatEvent>().call(
        droppable<ChatEvent>()
            .call(events.where((event) => event is _Refresh), mapper)
            .mergeWith([events.where((event) => event is _New)]),
        mapper,
      ),
    );
  }

  final ChatRepository _repository;
  final Session _session;

  _EventHandler get _handler => (event, emit) => event.map(
        refresh: (e) => _onRefresh(emit),
        newChat: (e) => _onNewChat(e, emit),
      );

  Future<void> _onRefresh(_Emitter emit) => tryEitherAsync(
        (_) async {
          emit(const ChatState.loading());

          final chats =
              await _repository.watchContacts(_session.address).toList();

          return chats
              .expand(identity)
              .map((it) => Chat(recipient: it.recipient, lastMessage: it.text))
              .toIList();
        },
      ).letAsync(
        (it) => it.fold(
          (_) => emit(const ChatState.none()),
          (it) => emit(ChatState.chats(it)),
        ),
      );

  Future<void> _onNewChat(_New e, _Emitter emit) async {
    // TODO(rhbrunetto): Sign tx, start xmtp convo (?)
  }
}
