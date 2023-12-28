import 'dart:convert';

import 'package:hoyo_launcher/commons/constant.dart';
import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';

SettingsEntity jsonStrToEntity(String jsonStr) {
  final Map<String, dynamic> json = jsonDecode(jsonStr) as Map<String, dynamic>;

  return SettingsEntity(
    themeMode: json['themeMode'] as int? ?? 0,
    darkAccentColor: json['darkAccentColor'] as int? ?? AppConstant.defAccentColor.value,
    lightAccentColor: json['lightAccentColor'] as int? ?? AppConstant.defAccentColor.value,
    useSystemAccentColor: json['useSystemAccentColor'] as bool? ?? true,
    clockConfig: json['clockConfig'] == null ? ClockConfig.def() : ClockConfig.fromStr(json['clockConfig'] as String),
    confirmBeforeClose: json['confirmBeforeClose'] as bool? ?? true,
    startWithFullScreen: json['startWithFullScreen'] as bool? ?? false,
    minimizeAfterLaunch: json['minimizeAfterLaunch'] as bool? ?? true,
  );
}
