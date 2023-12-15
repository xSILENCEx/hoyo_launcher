import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/window_buttons.dart';
import 'package:hoyo_launcher/theme.dart';
import 'package:window_manager/window_manager.dart';

import 'create_game_info/create_game_info_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WindowListener {
  int _selected = 0;

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
    final AppTheme appTheme = AppTheme();

    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: DragToMoveArea(child: Align(alignment: AlignmentDirectional.centerStart, child: Text(l10n.app_name))),
        actions: const Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[WindowButtons()]),
      ),
      pane: NavigationPane(
        selected: _selected,
        size: const NavigationPaneSize(openMaxWidth: 200, compactWidth: 50),
        displayMode: appTheme.displayMode,
        items: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: Container(color: Colors.black),
            onTap: () => setState(() => _selected = 0),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: Container(color: Colors.blue),
            onTap: () => setState(() => _selected = 1),
          ),
          _addItem(),
        ],
        footerItems: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: Container(color: Colors.green),
            onTap: CreateGameInfoPage.open,
          ),
        ],
      ),
    );
  }

  PaneItem _addItem() {
    return PaneItem(
      icon: const Icon(FluentIcons.add),
      title: Text(l10n.create_info),
      body: const SizedBox.shrink(),
      onTap: CreateGameInfoPage.open,
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
