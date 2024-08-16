import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/constant.dart';
import 'package:hoyo_launcher/commons/logger.dart';
import 'package:hoyo_launcher/presentation/gen/assets.gen.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_manager/window_manager.dart';

import 'widgets/window_buttons.dart';

Future<void> _tryOpenOfficialLauncherPath() async {
  try {
    if (appConfigNotifier.value.officialLauncherPath.isNotNullOrEmpty) {
      await launchUrlString(appConfigNotifier.value.officialLauncherPath!);
    }
  } catch (e) {
    errorLog(e.toString());
  }
}

NavigationAppBar buildAppBar() {
  return NavigationAppBar(
    automaticallyImplyLeading: false,
    title: DragToMoveArea(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: _tryOpenOfficialLauncherPath,
              child: R.imagesMihoyoLogo.svg(width: AppConstant.defAppBarHeight),
            ),
            const SizedBox(width: 6),
            Text(l10n.launcher, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
    actions: const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[WindowButtons()],
    ),
  );
}
