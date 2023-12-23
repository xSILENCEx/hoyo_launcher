import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/get_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/ui/settings/settings_page.dart';
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
            GameBgBuilder(gameInfo: gameInfoList.isEmpty ? null : gameInfoList[navIndex]),
            if (gameInfoList.isEmpty) const SizedBox.shrink() else GameInfoPage(gameInfo: gameInfoList[navIndex]),
            Positioned.fill(child: BlurBox(navBarWithNotifier)),
            NavigationView(
              appBar: buildAppBar(),
              content: Align(
                alignment: Alignment.centerLeft,
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
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> onWindowClose() async {
    final bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: <Widget>[
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
