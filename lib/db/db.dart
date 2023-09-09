import 'package:drift/drift.dart';

import '../features/chat/data/convo_repository.dart';
import '../features/chat/data/message_repository.dart';
import 'open_connection.dart';

part 'db.g.dart';

const int latestVersion = 1;

const _tables = [
  MessageRows,
  ConvoRows,
];

@DriftDatabase(tables: _tables)
class MyDatabase extends _$MyDatabase {
  MyDatabase._(QueryExecutor executor) : super(executor);

  MyDatabase.connect()
      : this._(DatabaseConnection.delayed(connectToDatabase('app.db')));

  @override
  int get schemaVersion => latestVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {},
      );
}
