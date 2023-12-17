import 'package:fluent_ui/fluent_ui.dart' hide Page, Colors;
import 'package:flutter/material.dart';
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
      onGenerateTitle: (BuildContext context) => l10nWithContext(context).app_name,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      color: appTheme.color,
      darkTheme: FluentThemeData.dark().copyWith(
        inactiveColor: Colors.grey,
        cardColor: const Color(0xff252525),
        visualDensity: VisualDensity.standard,
        scaffoldBackgroundColor: const Color(0xFF202020),
      ),
      theme: FluentThemeData(
        inactiveColor: Colors.grey,
        cardColor: const Color(0xffECECEC),
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
            data: const NavigationPaneThemeData(backgroundColor: Colors.transparent),
            child: child!,
          ),
        );
      },
      home: const Home(),
    );
  }
}
