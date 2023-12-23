import 'package:fluent_ui/fluent_ui.dart' hide Page, Colors;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/presentation/gen/l10n/app_localizations.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_builder.dart';
import 'package:system_theme/system_theme.dart';

import 'home/home.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(
      builder: (_, SystemAccentColor systemAccentColor) {
        final Color accentColor = systemAccentColor.accent;

        return ExBuilder<AppConfig>.child(
          valueListenable: appConfigNotifier,
          shouldRebuild: (AppConfig p, AppConfig n) =>
              p.darkAccentColor != n.darkAccentColor ||
              p.lightAccentColor != n.lightAccentColor ||
              p.themeMode != n.themeMode ||
              p.useSystemAccentColor != n.useSystemAccentColor,
          childBuilder: (AppConfig appConfig, Widget child) {
            final Color lightAccentColor = appConfig.useSystemAccentColor ? accentColor : appConfig.lightAccentColor;
            final Color darkAccentColor = appConfig.useSystemAccentColor ? accentColor : appConfig.darkAccentColor;

            return FluentApp(
              navigatorKey: navigatorKey,
              navigatorObservers: <NavigatorObserver>[routeObserver],
              onGenerateTitle: (BuildContext context) => l10nWithContext(context).app_name,
              themeMode: appConfig.themeMode,
              debugShowCheckedModeBanner: false,
              theme: FluentThemeData(
                accentColor: lightAccentColor.toAccentColor(),
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                scaffoldBackgroundColor: const Color(0xffF0F0F0),
                cardColor: const Color(0xffECECEC),
                visualDensity: VisualDensity.standard,
              ),
              darkTheme: FluentThemeData.dark().copyWith(
                accentColor: darkAccentColor.toAccentColor(),
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
              home: child,
            );
          },
          child: const Home(),
        );
      },
    );
  }
}
