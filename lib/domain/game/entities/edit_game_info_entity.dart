import 'game_info_action.dart';
import 'game_info_bg.dart';

/// 创建游戏信息实体
class EditGameInfoEntity {
  const EditGameInfoEntity._({
    required this.id,
    required this.moreActions,
    this.icon,
    this.title,
    this.launchPath,
    this.createTime,
    this.updateTime,
    this.gameBgInfo,
  });

  EditGameInfoEntity.create(this.id)
      : icon = null,
        title = null,
        launchPath = null,
        createTime = null,
        updateTime = null,
        gameBgInfo = null,
        moreActions = <GameInfoAction>[];

  const EditGameInfoEntity.edit({
    required this.id,
    required this.moreActions,
    this.icon,
    this.title,
    this.launchPath,
    this.gameBgInfo,
    this.createTime,
    this.updateTime,
  });

  final String id;
  final String? icon;
  final String? title;
  final String? launchPath;
  final DateTime? createTime;
  final DateTime? updateTime;

  final List<GameInfoAction> moreActions;

  final GameInfoBg? gameBgInfo;

  EditGameInfoEntity copyWith({
    String? id,
    String? icon,
    String? title,
    String? launchPath,
    GameInfoBg? background,
    DateTime? createTime,
    DateTime? updateTime,
    List<GameInfoAction>? moreActions,
    GameInfoBg? gameBgInfo,
  }) {
    return EditGameInfoEntity._(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      launchPath: launchPath ?? this.launchPath,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      moreActions: moreActions ?? this.moreActions,
      gameBgInfo: gameBgInfo ?? this.gameBgInfo,
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
      'createTime': createTime?.millisecondsSinceEpoch,
      'updateTime': updateTime?.millisecondsSinceEpoch,
      'moreActions': moreActions.map((GameInfoAction action) => action.toJsonString()).join('||'),
      'bgInfo': gameBgInfo?.toJson(),
    };
  }
}
