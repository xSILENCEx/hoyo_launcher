import 'game_info_bg.dart';
import 'image_transform_type.dart';

class RotationFolderBg extends GameInfoBg {
  const RotationFolderBg({
    required this.imageFolder,
    required this.transformType,
  });

  factory RotationFolderBg.fromJson(Map<String, dynamic> json) {
    return RotationFolderBg(
      imageFolder: json['imageFolder'] as String,
      transformType: ImageTransformType.fromString(json['transformType'] as String?),
    );
  }

  final String imageFolder;
  final ImageTransformType transformType;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageFolder': imageFolder,
      'transformType': transformType.value,
    };
  }

  @override
  RotationFolderBg copyWith({String? imageFolder, ImageTransformType? transformType}) {
    return RotationFolderBg(
      imageFolder: imageFolder ?? this.imageFolder,
      transformType: transformType ?? this.transformType,
    );
  }
}
