import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/constant.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/ui/settings/settings_page.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/confirm_dialog.dart';
import 'package:window_manager/window_manager.dart';

import 'app_bar.dart';
import 'edit_game_info/edit_game_info_page.dart';
import 'game_info/game_info_bg_builder.dart';
import 'game_info/game_info_page.dart';
import 'home_mixins/game_info_data_mixin.dart';
import 'home_mixins/nav_mixin.dart';
import 'nav_bar.dart';
import 'widgets/blur_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WindowListener, GameInfoDataMixin, NavMixin {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
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

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    if (!gameInfoList.contains(selectedIem)) {
      if (gameInfoList.isNotEmpty) {
        changeNavValue(gameInfoList.first);
      } else {
        changeNavValue(null);
      }
    } else {
      selectedIem = gameInfoList.firstWhere(firstWhereTest);
    }

    return Stack(
      children: <Widget>[
        Positioned.fill(child: ColoredBox(color: fluentTheme.scaffoldBackgroundColor)),
        if (selectedIem != null) GameBgBuilder(gameInfo: selectedIem!),
        if (selectedIem == null)
          Container(color: Colors.black.withOpacity(0.2))
        else
          GameInfoPage(gameInfo: selectedIem!),
        Positioned.fill(child: BlurBox(navBarWithNotifier)),
        Padding(
          padding: const EdgeInsets.only(top: AppConstant.defAppBarHeight),
          child: NavBar(
            onEditItemTap: EditGameInfoPage.edit,
            onDelItemTap: EditGameInfoPage.del,
            onAddItemTap: EditGameInfoPage.create,
            onSettingItemTap: SettingsPage.open,
            onNavHover: onNavHover,
            onItemTap: changeNav,
            selectItem: selectedIem,
            navItems: gameInfoList,
            onReorder: onReorder,
          ),
        ),
        SizedBox(
          height: AppConstant.defAppBarHeight,
          child: NavigationView(appBar: buildAppBar(), content: const SizedBox.shrink()),
        ),
      ],
    );
  }
}
