import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../db/db.dart';
import 'models/message.dart';

@injectable
class MessageRepository {
  const MessageRepository(this._db);

  final MyDatabase _db;

  Future<void> saveMessages(Iterable<Message> messages) =>
      _db.batch((batch) => batch.insertAll(
            _db.messageRows,
            messages.map((msg) => msg.toDto()),
            mode: InsertMode.insertOrIgnore,
          ),);

  Stream<IList<Message>> watchMessages({
    required String topic,
  }) {
    final messages = _db.select(_db.messageRows)
      ..where((p) => p.topic.equals(topic))
      ..orderBy([(t) => OrderingTerm.desc(t.sentAt)]);

    return messages
        .watch()
        .map((rows) => rows.map((r) => r.toModel()))
        .map((it) => it.toIList());
  }

  Future<Message?> readLastMessage(String topic) async {
    final query = _db.messageRows.select()
      ..where((it) => it.topic.equals(topic))
      ..orderBy([(it) => OrderingTerm.desc(it.sentAt)])
      ..limit(1);

    return query.map((it) => it.toModel()).getSingleOrNull();
  }

  Future<DateTime?> lastReceivedSentAt() async {
    final sentAtMax = _db.messageRows.sentAt.max();
    final query = _db.messageRows.selectOnly()..addColumns([sentAtMax]);

    return query.map((res) => res.read(sentAtMax)).getSingleOrNull();
  }

  Future<void> clear() => _db.delete(_db.messageRows).go();
}

class MessageRows extends Table {
  const MessageRows();

  TextColumn get id => text()();
  TextColumn get topic => text()();
  IntColumn get version => integer()();
  DateTimeColumn get sentAt => dateTime()();
  TextColumn get sender => text()();
  BlobColumn get encoded => blob()();

  @override
  Set<Column> get primaryKey => {id};
}

extension on MessageRow {
  Message toModel() => Message(
        id: id,
        topic: topic,
        version: version,
        sentAt: sentAt,
        sender: sender,
        encoded: encoded,
      );
}

extension on Message {
  MessageRow toDto() => MessageRow(
        id: id,
        topic: topic,
        version: version,
        sentAt: sentAt,
        sender: sender,
        encoded: encoded,
      );
}
