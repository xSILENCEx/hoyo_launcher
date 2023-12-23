import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hoyo_launcher/data_provider/data_source/local/storage/local_storage.dart';
import 'package:path/path.dart' as p;

import 'dao_list.dart';
import 'table_list.dart';

part 'generated/database.g.dart';

MyDatabase database = MyDatabase(_openConnection());

@DriftDatabase(tables: tableList, daos: daoList)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase(super.e);

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
    );
  }

  // Future<void> deleteDBFile() async {
  //   // final Directory dbFolder = await getApplicationDocumentsDirectory();
  //   // final File file = File(p.join(dbFolder.path, 'gps_db.sqlite'));
  //   // await file.delete();
  // }

  Future<void> deleteEverything() {
    return transaction(() async {
      await customStatement('PRAGMA foreign_keys = OFF');
      for (final TableInfo<Table, dynamic> table in allTables) {
        await delete<Table, dynamic>(table).go();
      }
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    final File file = File(p.join(appDirectoryPath, 'hoyo_launcher_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
