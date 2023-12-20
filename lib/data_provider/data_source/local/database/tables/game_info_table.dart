import 'package:drift/drift.dart';

@DataClassName('GameInfoDBModel')
class GameInfoTable extends Table {
  @override
  String? get tableName => 'game_info_table';

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  /// * [id] 游戏ID
  TextColumn get id => text()();

  /// * [icon] 游戏图标
  TextColumn get icon => text()();

  /// * [title] 游戏标题
  TextColumn get title => text()();

  /// * [launchPath] 游戏启动路径
  TextColumn get launchPath => text()();

  /// * [moreActions] 更多操作
  TextColumn get moreActions => text().nullable()();

  /// * [createTime] 创建时间
  DateTimeColumn get createTime => dateTime()();

  /// * [updateTime] 更新时间
  DateTimeColumn get updateTime => dateTime()();
}
