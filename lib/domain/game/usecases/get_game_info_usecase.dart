import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

class GetGameInfoUseCase {
  const GetGameInfoUseCase(this._gameRepository);

  final IGameInfoRepository _gameRepository;

  Future<GameInfoEntity?> getOne(String gameId) {
    return _gameRepository.getGameInfo(gameId);
  }

  Stream<List<GameInfoEntity>> watchGameInfoList() {
    return _gameRepository.getGameInfoListStream();
  }

  Future<List<GameInfoEntity>> getGameInfoList() {
    return _gameRepository.getGameInfoList();
  }
}
