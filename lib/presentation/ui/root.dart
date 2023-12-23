import 'package:fluent_ui/fluent_ui.dart' hide Page, Colors;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/presentation/gen/l10n/app_localizations.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:system_theme/system_theme.dart';

import 'home/home.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(builder: (_, SystemAccentColor accentColor) {
      return FluentApp(
        navigatorKey: navigatorKey,
        navigatorObservers: <NavigatorObserver>[routeObserver],
        onGenerateTitle: (BuildContext context) => l10nWithContext(context).app_name,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData(
          accentColor: accentColor.accent.toAccentColor(),
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          scaffoldBackgroundColor: const Color(0xffF0F0F0),
          cardColor: const Color(0xffECECEC),
          visualDensity: VisualDensity.standard,
        ),
        darkTheme: FluentThemeData.dark().copyWith(
          accentColor: const Color(0xff67768A).toAccentColor(),
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          scaffoldBackgroundColor: const Color(0xFF202020),
          cardColor: const Color(0xff252525),
          visualDensity: VisualDensity.standard,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (BuildContext context, Widget? child) {
          return NavigationPaneTheme(
            data: const NavigationPaneThemeData(backgroundColor: Colors.transparent),
            child: child!,
          );
        },
        home: const Home(),
      );
    });
  }
}
