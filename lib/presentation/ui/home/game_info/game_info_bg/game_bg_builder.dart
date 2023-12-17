import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';

import 'game_folder_loop_bg.dart';
import 'game_single_image_bg.dart';

Widget gameBgBuilder(GameInfoEntity gameInfo) {
  switch (gameInfo.gameBgType) {
    case GameInfoBgType.singleImage:
      return GameSingleImageBg(bgInfo: gameInfo.getBackground());
    case GameInfoBgType.folderRotation:
      return GameFolderLoopBg(bgInfo: gameInfo.getBackground());
    case GameInfoBgType.listRotation:
      throw UnimplementedError();
    case GameInfoBgType.unknown:
    case null:
      return Container(color: Colors.black.withOpacity(0.2));
  }
}
