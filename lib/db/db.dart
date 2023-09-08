import 'package:drift/drift.dart';
import 'package:eth_chat/features/chat/data/convo_repository.dart';
import 'package:eth_chat/features/chat/data/message_repository.dart';
import 'package:injectable/injectable.dart';

import 'open_connection.dart';

part 'db.g.dart';

const int latestVersion = 1;

const _tables = [
  MessageRows,
  ConvoRows,
];

@lazySingleton
@DriftDatabase(tables: _tables)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(openConnection());

  MyDatabase.connect(DatabaseConnection connection)
      : super(connection.executor);

  @override
  int get schemaVersion => latestVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {},
      );
}
