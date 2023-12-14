import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

class DelGameInfoUsecase {
  const DelGameInfoUsecase(this._gameInfoRepository);

  final IGameInfoRepository _gameInfoRepository;

  Future<void> call(String id) {
    return _gameInfoRepository.deleteGameInfo(id);
  }
}
