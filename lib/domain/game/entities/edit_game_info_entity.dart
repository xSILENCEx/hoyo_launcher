import 'game_info_action.dart';
import 'game_info_bg/game_info_bg.dart';
import 'game_info_bg_type.dart';

/// 创建游戏信息实体
class EditGameInfoEntity {
  const EditGameInfoEntity._({
    required this.id,
    required this.moreActions,
    this.icon,
    this.title,
    this.launchPath,
    this.gameBgType,
    this.background,
    this.createTime,
    this.updateTime,
  });

  EditGameInfoEntity.create(this.id)
      : icon = null,
        title = null,
        launchPath = null,
        createTime = null,
        updateTime = null,
        gameBgType = null,
        background = null,
        moreActions = <GameInfoAction>[];

  const EditGameInfoEntity.edit({
    required this.id,
    required this.moreActions,
    this.icon,
    this.title,
    this.launchPath,
    this.gameBgType,
    this.background,
    this.createTime,
    this.updateTime,
  });

  final String id;
  final String? icon;
  final String? title;
  final String? launchPath;
  final DateTime? createTime;
  final DateTime? updateTime;

  final GameInfoBgType? gameBgType;
  final GameInfoBg? background;
  final List<GameInfoAction> moreActions;

  EditGameInfoEntity copyWith({
    String? id,
    String? icon,
    String? title,
    String? launchPath,
    GameInfoBgType? gameBgType,
    GameInfoBg? background,
    DateTime? createTime,
    DateTime? updateTime,
    List<GameInfoAction>? moreActions,
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
      moreActions: moreActions ?? this.moreActions,
    );
  }

  EditGameInfoEntity addAction(GameInfoAction action) {
    final List<GameInfoAction> newActions = <GameInfoAction>[...moreActions, action];
    return copyWith(moreActions: newActions);
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
      'moreActions': moreActions.map((GameInfoAction action) => action.toJsonString()).join('||'),
    };
  }
}
