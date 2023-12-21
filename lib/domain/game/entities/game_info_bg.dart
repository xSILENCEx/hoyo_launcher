class GameInfoBg {
  const GameInfoBg({
    required this.id,
    required this.duration,
    required this.animatDuratuion,
    required this.bgData,
  });

  GameInfoBg.create(this.id)
      : duration = const Duration(seconds: 10),
        animatDuratuion = const Duration(milliseconds: 1000),
        bgData = const <String>[];

  final String id;
  final Duration duration;
  final Duration animatDuratuion;
  final List<String> bgData;

  GameInfoBg copyWith({
    String? id,
    Duration? duration,
    Duration? animatDuratuion,
    List<String>? bgData,
  }) {
    return GameInfoBg(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      animatDuratuion: animatDuratuion ?? this.animatDuratuion,
      bgData: bgData ?? this.bgData,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'duration': duration.inMilliseconds,
      'animatDuratuion': animatDuratuion.inMilliseconds,
      'bgData': bgData,
    };
  }
}
