import 'package:hoyo_launcher/commons/logger.dart';

enum GameInfoBgType {
  carousel._('CAROUSEL'),
  staticImage._('STATIC_IMAGE'),
  unknown._('UNKNOWN');

  const GameInfoBgType._(this.value);

  final String value;

  static GameInfoBgType? fromString(String? type) {
    if (type == null) return null;
    return GameInfoBgType.values.firstWhere(
      (GameInfoBgType e) => e.value == type,
      orElse: () {
        errorLog('Unkonwn GameInfoBgType: $type');
        return GameInfoBgType.unknown;
      },
    );
  }
}
