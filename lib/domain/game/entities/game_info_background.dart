import 'dart:convert';

import 'game_info_bg_type.dart';

/// 游戏背景
abstract class GameInfoBackground {
  const GameInfoBackground();

  static GameInfoBackground? generate(GameInfoBgType? type, String? value) {
    if (type == null || value == null) return null;

    final Map<String, dynamic> jsonData = jsonDecode(value) as Map<String, dynamic>;

    switch (type) {
      case GameInfoBgType.carousel:
        throw UnimplementedError();
      case GameInfoBgType.staticImage:
        throw UnimplementedError();
      case GameInfoBgType.unknown:
        return const _GameInfoBackground();
    }
  }

  Map<String, dynamic> toJson();

  String toJsonString() => jsonEncode(toJson());
}

class _GameInfoBackground extends GameInfoBackground {
  const _GameInfoBackground();

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};
}