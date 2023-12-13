import 'package:drift/drift.dart';

import 'database.dart';

class AppDatabaseAccessor extends DatabaseAccessor<MyDatabase> {
  AppDatabaseAccessor(MyDatabase db) : super(db);
}
