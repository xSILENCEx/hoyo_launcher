import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

class UpdateGameInfoUseCase {
  const UpdateGameInfoUseCase(this._gameRepository);

  final IGameInfoRepository _gameRepository;

  Future<void> call(GameInfoEntity game) async {
    await _gameRepository.saveGameInfo(game);
  }
}
