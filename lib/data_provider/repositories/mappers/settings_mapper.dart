import 'dart:convert';

import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';

SettingsEntity jsonStrToEntity(String jsonStr) {
  final Map<String, dynamic> json = jsonDecode(jsonStr) as Map<String, dynamic>;

  return SettingsEntity(
    themeMode: json['themeMode'] as int,
    darkAccentColor: json['darkAccentColor'] as int,
    lightAccentColor: json['lightAccentColor'] as int,
    useSystemAccentColor: json['useSystemAccentColor'] as bool,
    showClock: json['showClock'] as bool,
  );
}
