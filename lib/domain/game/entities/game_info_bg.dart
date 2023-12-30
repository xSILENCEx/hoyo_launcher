class GameInfoBg {
  const GameInfoBg({
    required this.id,
    required this.interval,
    required this.animateDuration,
    required this.random,
    required this.bgData,
  });

  GameInfoBg.create(this.id)
      : interval = const Duration(seconds: 10),
        animateDuration = const Duration(milliseconds: 500),
        random = false,
        bgData = const <String>[];

  final String id;
  final Duration interval;
  final Duration animateDuration;
  final bool random;
  final List<String> bgData;

  GameInfoBg copyWith({
    String? id,
    Duration? interval,
    Duration? animateDuration,
    bool? random,
    List<String>? bgData,
  }) {
    return GameInfoBg(
      id: id ?? this.id,
      interval: interval ?? this.interval,
      animateDuration: animateDuration ?? this.animateDuration,
      random: random ?? this.random,
      bgData: bgData ?? this.bgData,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'duration': interval.inMilliseconds,
      'animateDuration': animateDuration.inMilliseconds,
      'random': random,
      'bgData': bgData,
    };
  }
}
