import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

class CreateGameInfoUseCase {
  const CreateGameInfoUseCase(this._gameInfoRepository);

  final IGameInfoRepository _gameInfoRepository;

  Future<void> call(GameInfoEntity gameInfo) {
    return _gameInfoRepository.saveGameInfo(gameInfo);
  }
}
