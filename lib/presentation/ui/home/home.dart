import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/get_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:window_manager/window_manager.dart';

import 'create_game_info/edit_game_info_page.dart';
import 'game_info/game_info_page.dart';
import 'home_mixins/nav_mixin.dart';
import 'nav_bar.dart';
import 'widgets/app_bar.dart';

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
    return StreamBuilder<List<GameInfoEntity>>(
      stream: getIt.get<GetGameInfoUseCase>().watchGameInfoList(),
      builder: (_, AsyncSnapshot<List<GameInfoEntity>> snapshot) {
        final List<GameInfoEntity> gameInfoList = snapshot.data ?? <GameInfoEntity>[];

        return Stack(
          children: <Widget>[
            if (gameInfoList.isNotEmpty && navIndex < gameInfoList.length)
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: AppImg.cover(url: gameInfoList[navIndex].icon),
                ),
              ),
            Container(
              // color: Colors.red.withOpacity(0.2),
              color: const Color(0xFF202020).withOpacity(0.9),
            ),
            NavigationView(
              appBar: buildAppBar(),
              content: Row(
                children: <Widget>[
                  NavBar(
                    onEditItemTap: EditGameInfoPage.edit,
                    onSettingItemTap: () {},
                    onAddItemTap: EditGameInfoPage.create,
                    selectIndex: navIndex,
                    navItems: gameInfoList,
                    onItemTap: changeNav,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                      child: gameInfoList.isEmpty ? Container() : GameInfoPage(gameInfo: gameInfoList[navIndex]),
                    ),
                  ),
                ],
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
