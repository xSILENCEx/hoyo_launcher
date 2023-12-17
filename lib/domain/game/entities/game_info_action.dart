import 'dart:convert';

/// 菜单项
class GameInfoAction {
  const GameInfoAction({required this.name, required this.executePath});

  factory GameInfoAction.fromStr(String jsonStr) {
    final Map<String, dynamic> data = jsonDecode(jsonStr) as Map<String, dynamic>;

    return GameInfoAction(
      name: data['name'] as String,
      executePath: data['executePath'] as String,
    );
  }

  static List<GameInfoAction> generateList(String? moreActionsStr) {
    return moreActionsStr?.split('||').map((String actionStr) => GameInfoAction.fromStr(actionStr)).toList() ??
        <GameInfoAction>[];
  }

  final String name;
  final String executePath;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'executePath': executePath};
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
