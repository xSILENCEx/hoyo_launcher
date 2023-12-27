import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/settings/entities/clock_config.dart';
import 'package:hoyo_launcher/domain/settings/usecases/settings_usecase.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_switch.dart';

import 'clock_editer.dart';
import 'theme_color_selector.dart';
import 'theme_mode_selector.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage._();

  static Future<void> open() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const SettingsPage._(),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _reset() {
    appConfigNotifier.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(l10n.settings), m.TextButton(onPressed: _reset, child: Text(l10n.reset))],
      ),
      content: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
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
                ClockEditer(
                  initClockConfig: appConfigNotifier.value.clockConfig,
                  onShowClockChanged: (ClockConfig config) => appConfigNotifier.update(clockConfig: config),
                ),
              ),
              _buildDivider(),
              _buildRow(
                l10n.start_with_full,
                AppSwitch(
                  value: appConfigNotifier.value.startWithFullScreen,
                  onValueChanged: (bool value) => appConfigNotifier.update(startWithFullScreen: value),
                ),
              ),
              const SizedBox(height: 10),
              _buildRow(
                l10n.confirm_brfore_close,
                AppSwitch(
                  value: appConfigNotifier.value.confirmBeforeClose,
                  onValueChanged: (bool value) => appConfigNotifier.update(confirmBeforeClose: value),
                ),
              ),
              _buildDivider(),
              _buildRow(
                l10n.verison,
                Text(getIt.get<SettingsUsecase>().getVersion()),
              ),
            ],
          ),
        ),
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
