import 'game_info_bg.dart';
import 'image_transform_type.dart';

class RotationListBg extends GameInfoBg {
  const RotationListBg({
    required this.imageList,
    required this.transformType,
  });

  RotationListBg.empty()
      : imageList = <String>[],
        transformType = ImageTransformType.fade;

  factory RotationListBg.fromJson(Map<String, dynamic> json) {
    return RotationListBg(
      imageList: json['imageList'].toString().split(','),
      transformType: ImageTransformType.fromString(json['transformType'] as String?),
    );
  }

  final List<String> imageList;
  final ImageTransformType transformType;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageList': imageList.join(','),
      'transformType': transformType.value,
    };
  }

  @override
  RotationListBg copyWith({List<String>? imageList, ImageTransformType? transformType}) {
    return RotationListBg(
      imageList: imageList ?? this.imageList,
      transformType: transformType ?? this.transformType,
    );
  }
}
