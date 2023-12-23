import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_btn.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_builder.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'clock.dart';
import 'more_action_btn.dart';

const double _buttonHeight = 40;

class GameInfoPage extends StatelessWidget {
  const GameInfoPage({super.key, required this.gameInfo});

  final GameInfoEntity gameInfo;

  Future<void> _onStartGame(BuildContext context) async {
    try {
      launchUrlString(gameInfo.launchPath);
    } catch (e) {
      debugPrint(e.toString());
      AppInfoBar.show(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0).copyWith(top: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ExBuilder<AppConfig>(
            valueListenable: appConfigNotifier,
            shouldRebuild: (AppConfig p, AppConfig n) => p.clockConfig != n.clockConfig,
            builder: (AppConfig value) {
              if (!value.clockConfig.showClock) return const SizedBox.shrink();

              return const RepaintBoundary(child: Clock());
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AppBtn(
                onTap: () => _onStartGame(context),
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
