import 'package:hoyo_launcher/domain/game/entities/create_game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

GameInfoEntity _mapper(CreateGameInfoEntity createGameInfo) {
  return GameInfoEntity(
    id: createGameInfo.id,
    icon: createGameInfo.icon!,
    title: createGameInfo.title!,
    launchPath: createGameInfo.launchPath!,
    gameBgType: createGameInfo.gameBgType!,
    createTime: createGameInfo.createTime!,
    updateTime: createGameInfo.updateTime!,
    backgroundStr: createGameInfo.background!.toJsonString(),
    launcherPath: createGameInfo.launcherPath,
  );
}

class CreateGameInfoUseCase {
  const CreateGameInfoUseCase(this._gameInfoRepository);

  final IGameInfoRepository _gameInfoRepository;

  Future<void> call(CreateGameInfoEntity createGameInfo) {
    return _gameInfoRepository.saveGameInfo(_mapper(createGameInfo));
  }
}
