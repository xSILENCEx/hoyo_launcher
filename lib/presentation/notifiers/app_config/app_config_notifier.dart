import 'package:flutter/material.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/settings/entities/clock_config.dart';
import 'package:hoyo_launcher/domain/settings/usecases/settings_usecase.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_notifier.dart';

import 'app_config.dart';
export 'app_config.dart';

final AppConfigNotifier appConfigNotifier = AppConfigNotifier();

class AppConfigNotifier extends ExValue<AppConfig> {
  AppConfigNotifier() : super(AppConfig.init());

  void loadConfig(AppConfig config) => value = config;

  void update({
    ThemeMode? themeMode,
    Color? darkAccentColor,
    Color? lightAccentColor,
    bool? useSystemAccentColor,
    ClockConfig? clockConfig,
    bool? confirmBeforeClose,
  }) {
    final AppConfig newConfig = value.copyWith(
      themeMode: themeMode,
      darkAccentColor: darkAccentColor,
      lightAccentColor: lightAccentColor,
      useSystemAccentColor: useSystemAccentColor,
      clockConfig: clockConfig,
      confirmBeforeClose: confirmBeforeClose,
    );

    if (newConfig != value) {
      value = newConfig;
      getIt.get<SettingsUsecase>().updateSettings(value.settings);
    }
  }

  void reset() {
    value = AppConfig.init();
    getIt.get<SettingsUsecase>().updateSettings(value.settings);
  }
}
