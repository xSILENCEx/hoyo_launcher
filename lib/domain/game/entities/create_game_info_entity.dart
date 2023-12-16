import 'game_info_background.dart';
import 'game_info_bg_type.dart';

/// 创建游戏信息实体
class EditGameInfoEntity {
  const EditGameInfoEntity._({
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

  EditGameInfoEntity.create(this.id)
      : icon = null,
        title = null,
        launchPath = null,
        createTime = null,
        updateTime = null,
        launcherPath = null,
        gameBgType = null,
        background = null;

  const EditGameInfoEntity.edit({
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

  final String id;
  final String? icon;
  final String? title;
  final String? launchPath;
  final DateTime? createTime;
  final DateTime? updateTime;

  final String? launcherPath;
  final GameInfoBgType? gameBgType;
  final GameInfoBackground? background;

  EditGameInfoEntity copyWith({
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
    return EditGameInfoEntity._(
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'title': title,
      'launchPath': launchPath,
      'gameBgType': gameBgType?.index,
      'background': background?.toJsonString(),
      'createTime': createTime?.millisecondsSinceEpoch,
      'updateTime': updateTime?.millisecondsSinceEpoch,
      'launcherPath': launcherPath,
    };
  }
}
