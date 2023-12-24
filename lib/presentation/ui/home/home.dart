import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/constant.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/get_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/ui/settings/settings_page.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/confirm_dialog.dart';
import 'package:window_manager/window_manager.dart';

import 'app_bar.dart';
import 'edit_game_info/edit_game_info_page.dart';
import 'game_info/game_info_bg_builder.dart';
import 'game_info/game_info_page.dart';
import 'home_mixins/nav_mixin.dart';
import 'nav_bar.dart';
import 'widgets/blur_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WindowListener, NavMixin {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    return StreamBuilder<List<GameInfoEntity>>(
      stream: getIt.get<GetGameInfoUseCase>().watchGameInfoList(),
      builder: (_, AsyncSnapshot<List<GameInfoEntity>> snapshot) {
        final List<GameInfoEntity> gameInfoList = snapshot.data ?? <GameInfoEntity>[];

        return Stack(
          children: <Widget>[
            Positioned.fill(child: ColoredBox(color: fluentTheme.scaffoldBackgroundColor)),
            if (gameInfoList.isNotEmpty) GameBgBuilder(gameInfo: gameInfoList[navIndex]),
            if (gameInfoList.isEmpty)
              Container(color: Colors.black.withOpacity(0.2))
            else
              GameInfoPage(gameInfo: gameInfoList[navIndex]),
            Positioned.fill(child: BlurBox(navBarWithNotifier)),
            Padding(
              padding: const EdgeInsets.only(top: AppConstant.defAppBarHeight),
              child: NavBar(
                onEditItemTap: EditGameInfoPage.edit,
                onDelItemTap: EditGameInfoPage.del,
                onSettingItemTap: SettingsPage.open,
                onAddItemTap: EditGameInfoPage.create,
                onNavHover: onNavHover,
                selectIndex: navIndex,
                navItems: gameInfoList,
                onItemTap: changeNav,
              ),
            ),
            SizedBox(
              height: AppConstant.defAppBarHeight,
              child: NavigationView(appBar: buildAppBar(), content: const SizedBox.shrink()),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> onWindowClose() async {
    // final bool isPreventClose = await windowManager.isPreventClose();
    final bool confirmBeforeClose = appConfigNotifier.value.confirmBeforeClose;
    if (mounted) {
      if (confirmBeforeClose) {
        final bool close = await ConfirmDialog.show(l10n.confirm_close);
        if (!close) return;
      }

      windowManager.destroy();
    }
  }
}
