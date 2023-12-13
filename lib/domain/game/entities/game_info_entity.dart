import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'game_info_background.dart';
import 'game_info_bg_type.dart';

@immutable
class GameInfoEntity {
  GameInfoEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.launchPath,
    required this.gameBgType,
    required this.createTime,
    required this.updateTime,
    required String backgroundStr,
    this.launcherPath,
  }) : background = GameInfoBackground.generate(gameBgType, backgroundStr);

  final String id;
  final String icon;
  final String title;
  final String launchPath;
  final GameInfoBgType gameBgType;
  final GameInfoBackground background;
  final DateTime createTime;
  final DateTime updateTime;

  final String? launcherPath;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'title': title,
      'launchPath': launchPath,
      'gameBgType': gameBgType.value,
      'createTime': createTime.millisecondsSinceEpoch,
      'updateTime': updateTime.millisecondsSinceEpoch,
      'background': jsonEncode(background.toJson()),
      'launcherPath': launcherPath,
    };
  }

  @override
  bool operator ==(Object other) => other is GameInfoEntity && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
