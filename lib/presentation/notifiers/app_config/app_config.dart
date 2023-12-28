import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';

@immutable
class AppConfig {
  const AppConfig({
    required this.themeMode,
    required this.darkAccentColor,
    required this.lightAccentColor,
    required this.useSystemAccentColor,
    required this.clockConfig,
    required this.confirmBeforeClose,
    required this.startWithFullScreen,
    required this.minimizeAfterLaunch,
  });

  factory AppConfig.init() {
    return AppConfig.fromEntity(SettingsEntity.def());
  }

  factory AppConfig.fromEntity(SettingsEntity entity) {
    return AppConfig(
      themeMode: ThemeMode.values[entity.themeMode],
      darkAccentColor: Color(entity.darkAccentColor),
      lightAccentColor: Color(entity.lightAccentColor),
      useSystemAccentColor: entity.useSystemAccentColor,
      clockConfig: entity.clockConfig,
      confirmBeforeClose: entity.confirmBeforeClose,
      startWithFullScreen: entity.startWithFullScreen,
      minimizeAfterLaunch: entity.minimizeAfterLaunch,
    );
  }

  final ThemeMode themeMode;
  final Color darkAccentColor;
  final Color lightAccentColor;
  final bool useSystemAccentColor;
  final ClockConfig clockConfig;
  final bool confirmBeforeClose;
  final bool startWithFullScreen;
  final bool minimizeAfterLaunch;

  SettingsEntity get settings {
    return SettingsEntity(
      themeMode: themeMode.index,
      darkAccentColor: darkAccentColor.value,
      lightAccentColor: lightAccentColor.value,
      useSystemAccentColor: useSystemAccentColor,
      clockConfig: clockConfig,
      confirmBeforeClose: confirmBeforeClose,
      startWithFullScreen: startWithFullScreen,
      minimizeAfterLaunch: minimizeAfterLaunch,
    );
  }

  AppConfig copyWith({
    ThemeMode? themeMode,
    Color? darkAccentColor,
    Color? lightAccentColor,
    bool? useSystemAccentColor,
    ClockConfig? clockConfig,
    bool? confirmBeforeClose,
    bool? startWithFullScreen,
    bool? minimizeAfterLaunch,
  }) {
    return AppConfig(
      themeMode: themeMode ?? this.themeMode,
      darkAccentColor: darkAccentColor ?? this.darkAccentColor,
      lightAccentColor: lightAccentColor ?? this.lightAccentColor,
      useSystemAccentColor: useSystemAccentColor ?? this.useSystemAccentColor,
      clockConfig: clockConfig ?? this.clockConfig,
      confirmBeforeClose: confirmBeforeClose ?? this.confirmBeforeClose,
      startWithFullScreen: startWithFullScreen ?? this.startWithFullScreen,
      minimizeAfterLaunch: minimizeAfterLaunch ?? this.minimizeAfterLaunch,
    );
  }

  @override
  int get hashCode => Object.hash(themeMode, darkAccentColor, lightAccentColor, useSystemAccentColor, clockConfig,
      confirmBeforeClose, startWithFullScreen);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppConfig &&
            runtimeType == other.runtimeType &&
            themeMode == other.themeMode &&
            darkAccentColor == other.darkAccentColor &&
            lightAccentColor == other.lightAccentColor &&
            useSystemAccentColor == other.useSystemAccentColor &&
            clockConfig == other.clockConfig &&
            confirmBeforeClose == other.confirmBeforeClose &&
            startWithFullScreen == other.startWithFullScreen;
  }
}
