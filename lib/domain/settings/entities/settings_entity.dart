import 'dart:convert';

import 'package:hoyo_launcher/commons/constant.dart';

class SettingsEntity {
  const SettingsEntity({
    required this.themeMode,
    required this.darkAccentColor,
    required this.lightAccentColor,
    required this.useSystemAccentColor,
    required this.showClock,
  });

  factory SettingsEntity.def() {
    return SettingsEntity(
      themeMode: 0,
      darkAccentColor: AppConstant.defAccentColor.value,
      lightAccentColor: AppConstant.defAccentColor.value,
      useSystemAccentColor: true,
      showClock: true,
    );
  }

  final int themeMode;
  final int darkAccentColor;
  final int lightAccentColor;
  final bool useSystemAccentColor;
  final bool showClock;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'themeMode': themeMode,
      'darkAccentColor': darkAccentColor,
      'lightAccentColor': lightAccentColor,
      'useSystemAccentColor': useSystemAccentColor,
      'showClock': showClock,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
