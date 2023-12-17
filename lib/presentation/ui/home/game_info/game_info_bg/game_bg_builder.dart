import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';

import 'game_folder_loop_bg.dart';
import 'game_single_image_bg.dart';

class GameBgBuilder extends StatelessWidget {
  const GameBgBuilder({super.key, required this.gameInfo});

  final GameInfoEntity? gameInfo;

  @override
  Widget build(BuildContext context) {
    final GameInfoEntity? innerGameInfo = gameInfo;

    if (innerGameInfo == null) return Container(color: Colors.black.withOpacity(0.2));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<String>(innerGameInfo.id),
        child: _gameBgBuilder(context, innerGameInfo),
      ),
    );
  }

  Widget _gameBgBuilder(BuildContext context, GameInfoEntity info) {
    switch (info.gameBgType) {
      case GameInfoBgType.singleImage:
        return GameSingleImageBg(bgInfo: info.getBackground());
      case GameInfoBgType.folderRotation:
        return GameFolderLoopBg(bgInfo: info.getBackground());
      case GameInfoBgType.listRotation:
        throw UnimplementedError();
      case GameInfoBgType.unknown:
      case null:
        return _buildNullBg(context, info.icon);
    }
  }

  Widget _buildNullBg(BuildContext context, String icon) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    return Stack(
      children: <Widget>[
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: SizedBox.expand(child: AppImg.cover(url: icon)),
        ),
        Positioned.fill(child: ColoredBox(color: fluentTheme.scaffoldBackgroundColor.withOpacity(0.2))),
      ],
    );
  }
}
