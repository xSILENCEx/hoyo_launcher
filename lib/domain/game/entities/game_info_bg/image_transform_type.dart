import 'package:hoyo_launcher/commons/logger.dart';

enum ImageTransformType {
  fade._('FADE'),
  page._('PAGE'),
  unknown._('UNKNOWN');

  const ImageTransformType._(this.value);

  final String value;

  static ImageTransformType fromString(String? type) {
    return ImageTransformType.values.firstWhere(
      (ImageTransformType e) => e.value == type,
      orElse: () {
        errorLog('Unkonwn GameInfoBgType: $type');
        return ImageTransformType.unknown;
      },
    );
  }
}
