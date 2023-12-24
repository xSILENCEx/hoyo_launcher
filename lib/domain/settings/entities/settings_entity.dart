import 'dart:convert';

import 'package:hoyo_launcher/commons/constant.dart';

import 'clock_config.dart';
export 'clock_config.dart';

class SettingsEntity {
  const SettingsEntity({
    required this.themeMode,
    required this.darkAccentColor,
    required this.lightAccentColor,
    required this.useSystemAccentColor,
    required this.clockConfig,
  });

  factory SettingsEntity.def() {
    return SettingsEntity(
      themeMode: 0,
      darkAccentColor: AppConstant.defAccentColor.value,
      lightAccentColor: AppConstant.defAccentColor.value,
      useSystemAccentColor: true,
      clockConfig: ClockConfig.def(),
    );
  }

  final int themeMode;
  final int darkAccentColor;
  final int lightAccentColor;
  final bool useSystemAccentColor;
  final ClockConfig clockConfig;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'themeMode': themeMode,
      'darkAccentColor': darkAccentColor,
      'lightAccentColor': lightAccentColor,
      'useSystemAccentColor': useSystemAccentColor,
      'clockConfig': clockConfig.toJsonString(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}