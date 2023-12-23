import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/constant.dart';
import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';

@immutable
class AppConfig {
  const AppConfig({
    required this.themeMode,
    required this.darkAccentColor,
    required this.lightAccentColor,
    required this.useSystemAccentColor,
    required this.showClock,
  });

  factory AppConfig.init() {
    return const AppConfig(
      themeMode: ThemeMode.light,
      darkAccentColor: AppConstant.defAccentColor,
      lightAccentColor: AppConstant.defAccentColor,
      useSystemAccentColor: true,
      showClock: true,
    );
  }

  factory AppConfig.fromEntity(SettingsEntity entity) {
    return AppConfig(
      themeMode: ThemeMode.values[entity.themeMode],
      darkAccentColor: Color(entity.darkAccentColor),
      lightAccentColor: Color(entity.lightAccentColor),
      useSystemAccentColor: entity.useSystemAccentColor,
      showClock: entity.showClock,
    );
  }

  final ThemeMode themeMode;
  final Color darkAccentColor;
  final Color lightAccentColor;
  final bool useSystemAccentColor;
  final bool showClock;

  SettingsEntity get settings {
    return SettingsEntity(
      themeMode: themeMode.index,
      darkAccentColor: darkAccentColor.value,
      lightAccentColor: lightAccentColor.value,
      useSystemAccentColor: useSystemAccentColor,
      showClock: showClock,
    );
  }

  AppConfig copyWith({
    ThemeMode? themeMode,
    Color? darkAccentColor,
    Color? lightAccentColor,
    bool? useSystemAccentColor,
    bool? showClock,
  }) {
    return AppConfig(
      themeMode: themeMode ?? this.themeMode,
      darkAccentColor: darkAccentColor ?? this.darkAccentColor,
      lightAccentColor: lightAccentColor ?? this.lightAccentColor,
      useSystemAccentColor: useSystemAccentColor ?? this.useSystemAccentColor,
      showClock: showClock ?? this.showClock,
    );
  }

  @override
  int get hashCode => Object.hash(themeMode, darkAccentColor, lightAccentColor, useSystemAccentColor, showClock);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppConfig &&
            runtimeType == other.runtimeType &&
            themeMode == other.themeMode &&
            darkAccentColor == other.darkAccentColor &&
            lightAccentColor == other.lightAccentColor &&
            useSystemAccentColor == other.useSystemAccentColor &&
            showClock == other.showClock;
  }
}
