import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:hoyo_launcher/domain/settings/usecases/settings_usecase.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:window_size/window_size.dart' as window_size;

import 'commons/constant.dart';
import 'commons/getIt/di.dart';
import 'data_provider/data_source/local/package/package_info_tools.dart';
import 'data_provider/data_source/local/storage/local_storage.dart';
import 'presentation/notifiers/app_config/app_config_notifier.dart';
import 'presentation/ui/root.dart';

const String appTitle = 'Hoyo Launcher';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  await PackageTool.initDevice();

  SystemTheme.fallbackColor = AppConstant.defAccentColor;
  await SystemTheme.accentColor.load();

  configureDependencies();

  appConfigNotifier.loadConfig(AppConfig.fromEntity(getIt.get<SettingsUsecase>().getSettings()));

  await flutter_acrylic.Window.initialize();
  await flutter_acrylic.Window.hideWindowControls();

  await WindowManager.instance.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);

    await windowManager.setMinimumSize(const Size(600, 500));
    await windowManager.setSize(const Size(1200, 600));

    if (appConfigNotifier.value.startWithFullScreen) {
      await windowManager.setResizable(true);
      await windowManager.setFullScreen(true);
    } else {
      await windowManager.center();
    }

    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  });

  runApp(const RootApp());
}
