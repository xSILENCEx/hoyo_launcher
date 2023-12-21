import 'package:flutter/foundation.dart';

import 'game_info_action.dart';
import 'game_info_bg.dart';

export 'game_info_bg.dart';

@immutable
class GameInfoEntity {
  GameInfoEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.launchPath,
    required this.createTime,
    required this.updateTime,
    required this.gameBgInfo,
    String? moreActionsStr,
    List<GameInfoAction>? moreActions,
  }) : moreActions = moreActions ?? GameInfoAction.generateList(moreActionsStr);

  final String id;
  final String icon;
  final String title;
  final String launchPath;
  final DateTime createTime;
  final DateTime updateTime;

  final List<GameInfoAction> moreActions;

  final GameInfoBg gameBgInfo;

  String? genMoreActionsStr() {
    return moreActions.isEmpty ? null : moreActions.map((GameInfoAction action) => action.toJsonString()).join('||');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'title': title,
      'launchPath': launchPath,
      'createTime': createTime.millisecondsSinceEpoch,
      'updateTime': updateTime.millisecondsSinceEpoch,
      'moreActions': genMoreActionsStr(),
      'bgInfo': gameBgInfo.toJson(),
    };
  }

  @override
  bool operator ==(Object other) => other is GameInfoEntity && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
