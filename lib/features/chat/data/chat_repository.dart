// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:eth_chat/db/db.dart';
import 'package:eth_chat/features/chat/data/message.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ChatRepository {
  const ChatRepository(this._db);

  final MyDatabase _db;

  Future<Message?> load(String id) {
    final query = _db.select(_db.messageRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Future<void> save(Message message) async =>
      await _db.into(_db.messageRows).insertOnConflictUpdate(message.toDto());

  Stream<IList<Message>> watch({
    required String sender,
    required String recipient,
  }) {
    final sent = _db.select(_db.messageRows)
      ..where((p) => p.recipient.equals(recipient))
      ..where((p) => p.sender.equals(sender));
    final received = _db.select(_db.messageRows)
      ..where((p) => p.recipient.equals(sender))
      ..where((p) => p.sender.equals(recipient));

    final sentStream = sent.watch().map((rows) => rows.map((r) => r.toModel()));
    final receivedStream =
        received.watch().map((rows) => rows.map((r) => r.toModel()));

    return Rx.combineLatest<Iterable<Message>, IList<Message>>(
      [
        sentStream,
        receivedStream,
      ],
      (values) => values
          .expand(identity)
          .toIList()
          .sortOrdered((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  Future<void> clear() => _db.delete(_db.messageRows).go();
}

class MessageRows extends Table {
  const MessageRows();

  TextColumn get id => text()();
  TextColumn get sender => text()();
  TextColumn get recipient => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

extension on MessageRow {
  Message toModel() => Message(
        id: id,
        recipient: recipient,
        sender: sender,
        createdAt: createdAt,
        text: data,
      );
}

extension on Message {
  MessageRow toDto() => MessageRow(
        id: id,
        recipient: recipient,
        sender: sender,
        createdAt: createdAt,
        data: text,
      );
}
