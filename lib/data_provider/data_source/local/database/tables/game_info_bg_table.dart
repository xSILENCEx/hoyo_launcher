import 'package:drift/drift.dart';

@DataClassName('GameInfoBgDBModel')
class GameInfoBgTable extends Table {
  @override
  String? get tableName => 'game_info_bg_table';

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  /// * [id] 游戏ID
  TextColumn get id => text()();

  /// * [duration] 切换间隔时间
  IntColumn get duration => integer()();

  /// * [animatDuratuion] 过度动画时长
  IntColumn get animatDuratuion => integer()();

  /// * 随机切换
  BoolColumn get random => boolean().nullable()();

  /// * [bgData] 背景数据
  TextColumn get bgData => text()();
}
