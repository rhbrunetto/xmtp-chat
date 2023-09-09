import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../db/db.dart';
import 'models/convo.dart';

@injectable
class ConvoRepository {
  const ConvoRepository(this._db);

  final MyDatabase _db;

  Stream<IList<Convo>> watchConversations() {
    final query = _db.convoRows.select()
      ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]);

    return query.map((it) => it.toModel()).watch().map((it) => it.toIList());
  }

  Future<void> saveConversations(Iterable<Convo> convos) =>
      _db.batch((batch) => batch.insertAll(
            _db.convoRows,
            convos.map((it) => it.toDto()),
            mode: InsertMode.insertOrIgnore,
          ),);

  Future<Convo?> read(String topic) async {
    final query = _db.convoRows.select()..where((t) => t.topic.equals(topic));

    return query.map((it) => it.toModel()).getSingleOrNull();
  }

  Future<IList<Convo>> readConversations() async {
    final query = _db.convoRows.select()
      ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]);

    return query.map((it) => it.toModel()).get().letAsync((it) => it.toIList());
  }

  Future<Convo?> readLastConversation() async {
    final query = _db.convoRows.select()
      ..orderBy([(c) => OrderingTerm.desc(c.createdAt)])
      ..limit(1);

    return query.map((c) => c.toModel()).getSingleOrNull();
  }

  Future<IList<Convo>> readEmptyConversations() async {
    final query = _db.convoRows.select()
      ..where(
        (c) => notExistsQuery(
          _db.messageRows.select()
            ..where((msg) => msg.topic.equalsExp(c.topic)),
        ),
      );

    return query.map((c) => c.toModel()).get().letAsync((it) => it.toIList());
  }

  Future<void> clear() => _db.delete(_db.convoRows).go();
}

class ConvoRows extends Table {
  const ConvoRows();

  TextColumn get topic => text()();
  IntColumn get version => integer()();
  DateTimeColumn get createdAt => dateTime()();
  BlobColumn get invite => blob()();
  TextColumn get me => text()();
  TextColumn get peer => text()();
  DateTimeColumn get lastOpenedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {topic};
}

extension on ConvoRow {
  Convo toModel() => Convo(
        topic: topic,
        version: version,
        createdAt: createdAt,
        invite: invite,
        me: me,
        peer: peer,
        lastOpenedAt: lastOpenedAt,
      );
}

extension on Convo {
  ConvoRow toDto() => ConvoRow(
        topic: topic,
        version: version,
        createdAt: createdAt,
        invite: invite,
        me: me,
        peer: peer,
        lastOpenedAt: lastOpenedAt,
      );
}
