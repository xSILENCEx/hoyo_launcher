import 'dart:convert';

import 'package:hoyo_launcher/domain/game/entities/game_info_bg/rotation_list_bg.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg_type.dart';

import 'rotation_folder_bg.dart';
import 'single_image_bg.dart';
export 'package:hoyo_launcher/domain/game/entities/game_info_bg_type.dart';

/// 游戏背景
abstract class GameInfoBg {
  const GameInfoBg();

  static GameInfoBg? generate(GameInfoBgType? type, String? value) {
    if (type == null || value == null) return null;

    final Map<String, dynamic> jsonData = jsonDecode(value) as Map<String, dynamic>;

    switch (type) {
      case GameInfoBgType.folderRotation:
        return RotationFolderBg.fromJson(jsonData);
      case GameInfoBgType.listRotation:
        return RotationListBg.fromJson(jsonData);
      case GameInfoBgType.singleImage:
        return SingleImageBg.fromJson(jsonData);
      case GameInfoBgType.unknown:
        return const _GameInfoBackground();
    }
  }

  static GameInfoBg getEmpty(GameInfoBgType type) {
    switch (type) {
      case GameInfoBgType.folderRotation:
        return const RotationFolderBg.empty();
      case GameInfoBgType.listRotation:
        return RotationListBg.empty();
      case GameInfoBgType.singleImage:
        return const SingleImageBg.empty();
      case GameInfoBgType.unknown:
        return const _GameInfoBackground();
    }
  }

  Map<String, dynamic> toJson();

  GameInfoBg copyWith();

  String toJsonString() => jsonEncode(toJson());
}

class _GameInfoBackground extends GameInfoBg {
  const _GameInfoBackground();

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  GameInfoBg copyWith() => this;
}
