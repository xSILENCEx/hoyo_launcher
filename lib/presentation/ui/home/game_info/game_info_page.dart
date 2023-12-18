import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_btn.dart';

import 'more_action_btn.dart';

const double _buttonHeight = 40;

class GameInfoPage extends StatelessWidget {
  const GameInfoPage({super.key, required this.gameInfo});

  final GameInfoEntity gameInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AppBtn(
                onTap: () {},
                width: _buttonHeight * 4,
                height: _buttonHeight,
                alignment: Alignment.center,
                child: Text(
                  l10n.start_game,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              MoreActionBtn(actions: gameInfo.moreActions, btnSize: _buttonHeight),
            ],
          ),
        ],
      ),
    );
  }
}
