import 'entities/game_info_entity.dart';

abstract class IGameInfoRepository {
  /// 获取游戏信息列表流
  Stream<List<GameInfoEntity>> getGameInfoListStream();

  /// 获取游戏信息列表
  Future<List<GameInfoEntity>> getGameInfoList();

  /// 获取游戏信息
  Future<GameInfoEntity?> getGameInfo(String gameId);

  /// 保存游戏信息
  Future<void> saveGameInfo(GameInfoEntity gameInfo);

  /// 删除游戏信息
  Future<void> deleteGameInfo(String gameId);
}
