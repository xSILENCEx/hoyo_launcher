import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:hoyo_launcher/domain/settings/usecases/settings_usecase.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'package:windows_single_instance/windows_single_instance.dart';

import 'commons/constant.dart';
import 'commons/getIt/di.dart';
import 'data_provider/data_source/local/package/package_info_tools.dart';
import 'data_provider/data_source/local/storage/local_storage.dart';
import 'presentation/notifiers/app_config/app_config_notifier.dart';
import 'presentation/ui/root.dart';

const String appTitle = 'Hoyo Launcher';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowsSingleInstance.ensureSingleInstance(args, 'com.hoyo_launcher');

  await LocalStorage.init();
  await PackageTool.initDevice();

  SystemTheme.fallbackColor = AppConstant.defAccentColor;
  await SystemTheme.accentColor.load();

  configureDependencies();

  appConfigNotifier.loadConfig(AppConfig.fromEntity(getIt.get<SettingsUsecase>().getSettings()));

  await flutter_acrylic.Window.initialize();
  await flutter_acrylic.Window.hideWindowControls();

  await WindowManager.instance.ensureInitialized();

  final window_size.Screen? screen = await window_size.getCurrentScreen();

  double screenWidth = 1200;

  if (screen != null) {
    screenWidth = screen.visibleFrame.size.width * 0.5;
  }

  final double screenHeight = screenWidth / 2;

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);

    await windowManager.setMinimumSize(const Size(600, 500));
    await windowManager.setSize(Size(screenWidth, screenHeight));

    if (!appConfigNotifier.value.startWithFullScreen) {
      await windowManager.center();
    } else {
      await windowManager.maximize();
    }

    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  });

  runApp(const RootApp());
}
