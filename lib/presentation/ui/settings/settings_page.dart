import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';

import 'show_clock_switch.dart';
import 'theme_color_selector.dart';
import 'theme_mode_selector.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._();

  static Future<void> open() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const SettingsPage._(),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: Text(l10n.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildRow(
            l10n.theme_mode,
            ThemeModeSelector(
              initThemeMode: appConfigNotifier.value.themeMode,
              onThemeModeChanged: (ThemeMode themeMode) => appConfigNotifier.update(themeMode: themeMode),
            ),
          ),
          _buildDivider(),
          _buildRow(
            l10n.theme_color,
            ThemeColorSelector(
              initUseSystemAccentColor: appConfigNotifier.value.useSystemAccentColor,
              initDarkAccentColor: appConfigNotifier.value.darkAccentColor,
              initLightAccentColor: appConfigNotifier.value.lightAccentColor,
              onThemeColorChanged: (bool useSystemAccentColor, Color darkAccentColor, Color lightAccentColor) =>
                  appConfigNotifier.update(
                useSystemAccentColor: useSystemAccentColor,
                darkAccentColor: darkAccentColor,
                lightAccentColor: lightAccentColor,
              ),
            ),
          ),
          _buildDivider(),
          _buildRow(
            l10n.show_clock,
            ShowClockSwitch(
              initShowClock: appConfigNotifier.value.showClock,
              onShowClockChanged: (bool showClock) => appConfigNotifier.update(showClock: showClock),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        SizedBox(width: 150, child: FilledButton(onPressed: () => Navigator.pop(context), child: Text(l10n.close))),
      ],
    );
  }

  Widget _buildRow(String text, Widget trailing) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 32, child: Center(widthFactor: 1, child: Text(text.withColon))),
        Flexible(child: trailing)
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(style: DividerThemeData(horizontalMargin: EdgeInsets.symmetric(vertical: 10)));
  }
}
