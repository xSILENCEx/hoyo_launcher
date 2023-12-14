import 'package:fluent_ui/fluent_ui.dart' hide Page, Colors;
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:hoyo_launcher/presentation/gen/l10n/app_localizations.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/theme.dart';

import 'home/home.dart';

final AppTheme _appTheme = AppTheme();

class Root extends StatelessWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = _appTheme;
    return FluentApp(
      navigatorKey: navigatorKey,
      navigatorObservers: <NavigatorObserver>[routeObserver],
      onGenerateTitle: (BuildContext context) {
        return l10nWithContext(context).app_name;
      },
      themeMode: appTheme.mode,
      debugShowCheckedModeBanner: false,
      color: appTheme.color,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: appTheme.textDirection,
          child: NavigationPaneTheme(
            data: NavigationPaneThemeData(
              backgroundColor:
                  appTheme.windowEffect != flutter_acrylic.WindowEffect.disabled ? Colors.transparent : null,
            ),
            child: child!,
          ),
        );
      },
      home: const Home(),
    );
  }
}
