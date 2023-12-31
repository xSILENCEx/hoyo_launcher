import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hoyo_launcher/commons/constant.dart';

@immutable
class ClockConfig {
  const ClockConfig({
    required this.showClock,
    required this.dateIcon,
    required this.blurRadius,
    required this.shadowColor,
    required this.blurX,
    required this.blurY,
    required this.showSecond,
    required this.scale,
  });

  factory ClockConfig.def() {
    return ClockConfig(
      showClock: true,
      dateIcon: '  🌱  ',
      blurRadius: 5,
      shadowColor: AppConstant.defShadowColor.value,
      blurX: 1,
      blurY: 1,
      showSecond: true,
      scale: 1,
    );
  }

  factory ClockConfig.fromStr(String str) {
    final Map<String, dynamic> map = jsonDecode(str) as Map<String, dynamic>;

    return ClockConfig(
      showClock: map['showClock'] as bool? ?? true,
      dateIcon: map['dateIcon'] as String? ?? '  🌱  ',
      blurRadius: map['blurRadius'] as double? ?? 5,
      shadowColor: map['shadowColor'] as int? ?? AppConstant.defShadowColor.value,
      blurX: map['blurX'] as double? ?? 1,
      blurY: map['blurY'] as double? ?? 1,
      showSecond: map['showSecond'] as bool? ?? true,
      scale: map['scale'] as double? ?? 1,
    );
  }

  final bool showClock;
  final String dateIcon;
  final double blurRadius;
  final int shadowColor;
  final double blurX;
  final double blurY;
  final bool showSecond;
  final double scale;

  ClockConfig copyWith({
    bool? showClock,
    String? dateIcon,
    double? blurRadius,
    int? shadowColor,
    double? blurX,
    double? blurY,
    bool? showSecond,
    double? scale,
  }) {
    return ClockConfig(
      showClock: showClock ?? this.showClock,
      dateIcon: dateIcon ?? this.dateIcon,
      blurRadius: blurRadius ?? this.blurRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      blurX: blurX ?? this.blurX,
      blurY: blurY ?? this.blurY,
      showSecond: showSecond ?? this.showSecond,
      scale: scale ?? this.scale,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'showClock': showClock,
      'dateIcon': dateIcon,
      'blurRadius': blurRadius,
      'shadowColor': shadowColor,
      'blurX': blurX,
      'blurY': blurY,
      'showSecond': showSecond,
      'scale': scale,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  @override
  int get hashCode => Object.hash(showClock, dateIcon, blurRadius, shadowColor, blurX, blurY, showSecond, scale);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClockConfig &&
        other.showClock == showClock &&
        other.dateIcon == dateIcon &&
        other.blurRadius == blurRadius &&
        other.shadowColor == shadowColor &&
        other.blurX == blurX &&
        other.blurY == blurY &&
        other.showSecond == showSecond &&
        other.scale == scale;
  }
}
