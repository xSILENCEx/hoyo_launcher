// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:drift/drift.dart';

import '../database.dart';
import '../lock_database_accessor.dart';
import '../models/full_game_info_db_model.dart';
import '../tables/game_info_bg_table.dart';
import '../tables/game_info_table.dart';

part 'generated/game_info_dao.g.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

GameInfoDao get gameInfoDao => GameInfoDao(database);

@DriftAccessor(tables: <Type>[GameInfoTable, GameInfoBgTable])
class GameInfoDao extends AppDatabaseAccessor with _$GameInfoDaoMixin {
  GameInfoDao(MyDatabase db) : super(db);

  Future<void> upsert(FullGameInfoDBModel model) async {
    await into(gameInfoBgTable).insertOnConflictUpdate(model.gameInfoBgDBModel);
    await into(gameInfoTable).insertOnConflictUpdate(model.gameInfoDBModel);
  }

  Future<void> upsertAll(List<FullGameInfoDBModel> list) async {
    // 使用批量操作
    await batch((Batch batch) {
      batch.insertAllOnConflictUpdate(gameInfoTable, list.map((FullGameInfoDBModel e) => e.gameInfoDBModel).toList());
    });

    final List<GameInfoBgDBModel> bgList = <GameInfoBgDBModel>[];
    for (final FullGameInfoDBModel e in list) {
      bgList.add(e.gameInfoBgDBModel);
    }

    if (bgList.isNotEmpty) {
      await batch((Batch batch) {
        batch.insertAllOnConflictUpdate(gameInfoBgTable, bgList);
      });
    }
  }

  Stream<List<FullGameInfoDBModel>> watchGameInfoList() {
    return _joinQuery().watch();
  }

  Future<List<FullGameInfoDBModel>> getGameInfoList() async {
    return _joinQuery().get();
  }

  /// 获取指定id的游戏信息
  Future<FullGameInfoDBModel?> getGameInfo(String id) async {
    return _joinQuery(id: id).getSingleOrNull();
  }

  /// 删除游戏信息
  Future<void> deleteGameInfo(String id) async {
    final DeleteStatement<GameInfoTable, GameInfoDBModel> basicInfo = delete(gameInfoTable);
    basicInfo.where((GameInfoTable t) => t.id.equals(id));
    await basicInfo.go();

    final DeleteStatement<GameInfoBgTable, GameInfoBgDBModel> bgInfo = delete(gameInfoBgTable);
    bgInfo.where((GameInfoBgTable t) => t.id.equals(id));
    await bgInfo.go();
  }

  /// 联表查询
  Selectable<FullGameInfoDBModel> _joinQuery({String? id}) {
    final JoinedSelectStatement<HasResultSet, dynamic> q = _baseGet(id: id).join(
      <Join<HasResultSet, dynamic>>[
        leftOuterJoin(gameInfoBgTable, gameInfoTable.id.equalsExp(gameInfoBgTable.id)),
      ],
    );

    return q.map((TypedResult row) {
      final GameInfoDBModel gameInfo = row.readTable(gameInfoTable);
      final GameInfoBgDBModel gameInfoBg = row.readTable(gameInfoBgTable);
      return FullGameInfoDBModel(gameInfo, gameInfoBg);
    });
  }

  /// 基础查询
  SimpleSelectStatement<GameInfoTable, GameInfoDBModel> _baseGet({String? id}) {
    final SimpleSelectStatement<GameInfoTable, GameInfoDBModel> query =
        select<GameInfoTable, GameInfoDBModel>(gameInfoTable);

    query.orderBy(
      <OrderingTerm Function(GameInfoTable)>[
        (_) => OrderingTerm(expression: gameInfoTable.sortValue),
      ],
    );

    if (id != null) {
      query.where((GameInfoTable t) => t.id.equals(id));
    }

    return query;
  }
}
