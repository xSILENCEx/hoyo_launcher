import 'package:hoyo_launcher/data_provider/data_source/local/database/daos/game_info_dao.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';
import 'package:injectable/injectable.dart';

import 'mappers/game_info_mapper.dart';

@Injectable(as: IGameInfoRepository)
class GameInfoRepository implements IGameInfoRepository {
  @override
  Stream<List<GameInfoEntity>> getGameInfoListStream() {
    return gameInfoDao.watchGameInfoList().map(gameInfoDBListToEntityList);
  }

  @override
  Future<void> deleteGameInfo(String gameId) {
    return gameInfoDao.deleteGameInfo(gameId);
  }

  @override
  Future<GameInfoEntity?> getGameInfo(String gameId) {
    return gameInfoDao.getGameInfo(gameId).then(gameInfoDBToEntityNullable);
  }

  @override
  Future<List<GameInfoEntity>> getGameInfoList() {
    return gameInfoDao.getGameInfoList().then(gameInfoDBListToEntityList);
  }

  @override
  Future<void> saveGameInfo(GameInfoEntity gameInfo) {
    return gameInfoDao.upsert(gameInfoEntityToDB(gameInfo));
  }
}
