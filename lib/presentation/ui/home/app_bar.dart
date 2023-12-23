import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/gen/assets.gen.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:window_manager/window_manager.dart';

import 'widgets/window_buttons.dart';

NavigationAppBar buildAppBar() {
  return NavigationAppBar(
    automaticallyImplyLeading: false,
    title: DragToMoveArea(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: <Widget>[
            R.imagesMihoyoLogo.svg(width: 50),
            const SizedBox(width: 6),
            Text(l10n.launcher, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
    actions: const Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[WindowButtons()]),
  );
}
