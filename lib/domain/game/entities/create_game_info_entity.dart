import 'game_info_background.dart';
import 'game_info_bg_type.dart';

/// 创建游戏信息实体
class CreateGameInfoEntity {
  const CreateGameInfoEntity._({
    required this.id,
    this.icon,
    this.title,
    this.launchPath,
    this.gameBgType,
    this.background,
    this.createTime,
    this.updateTime,
    this.launcherPath,
  });

  CreateGameInfoEntity.create(this.id)
      : icon = null,
        title = null,
        launchPath = null,
        gameBgType = null,
        background = null,
        createTime = null,
        updateTime = null,
        launcherPath = null;

  final String id;
  final String? icon;
  final String? title;
  final String? launchPath;
  final GameInfoBgType? gameBgType;
  final GameInfoBackground? background;
  final DateTime? createTime;
  final DateTime? updateTime;
  final String? launcherPath;

  CreateGameInfoEntity copyWith({
    String? id,
    String? icon,
    String? title,
    String? launchPath,
    GameInfoBgType? gameBgType,
    GameInfoBackground? background,
    DateTime? createTime,
    DateTime? updateTime,
    String? launcherPath,
  }) {
    return CreateGameInfoEntity._(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      launchPath: launchPath ?? this.launchPath,
      gameBgType: gameBgType ?? this.gameBgType,
      background: background ?? this.background,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      launcherPath: launcherPath ?? this.launcherPath,
    );
  }
}
