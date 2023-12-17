import 'game_info_bg.dart';

class SingleImageBg extends GameInfoBg {
  const SingleImageBg({required this.imageUrl});

  const SingleImageBg.empty() : imageUrl = '';

  factory SingleImageBg.fromJson(Map<String, dynamic> json) {
    return SingleImageBg(imageUrl: json['imageUrl'] as String);
  }

  final String imageUrl;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'imageUrl': imageUrl};
  }

  @override
  SingleImageBg copyWith({String? imageUrl}) {
    return SingleImageBg(imageUrl: imageUrl ?? this.imageUrl);
  }
}
