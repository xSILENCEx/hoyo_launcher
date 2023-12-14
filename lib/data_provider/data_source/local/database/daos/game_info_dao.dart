// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:drift/drift.dart';

import '../database.dart';
import '../lock_database_accessor.dart';
import '../tables/game_info_table.dart';

part 'generated/game_info_dao.g.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

GameInfoDao get gameInfoDao => GameInfoDao(database);

@DriftAccessor(tables: <Type>[GameInfoTable])
class GameInfoDao extends AppDatabaseAccessor with _$GameInfoDaoMixin {
  GameInfoDao(MyDatabase db) : super(db);

  Future<void> upsert(GameInfoDBModel model) {
    return into(gameInfoTable).insertOnConflictUpdate(model);
  }

  Future<void> upsertAll(List<GameInfoDBModel> list) async {
    // 使用批量操作
    await batch((Batch batch) {
      batch.insertAllOnConflictUpdate(gameInfoTable, list);
    });
  }

  Stream<List<GameInfoDBModel>> watchGameInfoList() {
    final SimpleSelectStatement<GameInfoTable, GameInfoDBModel> query = _baseGet();
    return query.watch();
  }

  Future<List<GameInfoDBModel>> getGameInfoList() async {
    final SimpleSelectStatement<GameInfoTable, GameInfoDBModel> query = _baseGet();
    return query.get();
  }

  /// 获取指定id的游戏信息
  Future<GameInfoDBModel?> getGameInfo(String id) async {
    final SimpleSelectStatement<GameInfoTable, GameInfoDBModel> query = _baseGet();
    query.where((GameInfoTable t) => t.id.equals(id));
    return query.getSingleOrNull();
  }

  /// 删除游戏信息
  Future<void> deleteGameInfo(String id) async {
    final DeleteStatement<GameInfoTable, GameInfoDBModel> statement = delete(gameInfoTable);
    statement.where((GameInfoTable t) => t.id.equals(id));
    await statement.go();
  }

  /// 基础查询
  SimpleSelectStatement<GameInfoTable, GameInfoDBModel> _baseGet() {
    final SimpleSelectStatement<GameInfoTable, GameInfoDBModel> query =
        select<GameInfoTable, GameInfoDBModel>(gameInfoTable);

    query.orderBy(
      <OrderingTerm Function(GameInfoTable)>[
        (_) => OrderingTerm(expression: gameInfoTable.createTime),
      ],
    );

    return query;
  }
}
