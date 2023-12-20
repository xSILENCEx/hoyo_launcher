class GameInfoBg {
  GameInfoBg({
    required this.id,
    required this.duration,
    required this.animatDuratuion,
    required this.bgData,
  });

  final String id;
  final Duration duration;
  final Duration animatDuratuion;
  final List<String> bgData;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'duration': duration.inMilliseconds,
      'animatDuratuion': animatDuratuion.inMilliseconds,
      'bgData': bgData,
    };
  }
}
