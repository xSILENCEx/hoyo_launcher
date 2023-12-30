import 'package:hoyo_launcher/domain/game/entities/edit_game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/i_game_info_repository.dart';

GameInfoEntity _genMapper(EditGameInfoEntity editGameInfo) {
  return GameInfoEntity(
    id: editGameInfo.id,
    icon: editGameInfo.icon!,
    title: editGameInfo.title!,
    launchPath: editGameInfo.launchPath!,
    createTime: editGameInfo.createTime!,
    updateTime: editGameInfo.updateTime!,
    sortValue: editGameInfo.sortValue!,
    moreActions: editGameInfo.moreActions,
    gameBgInfo: editGameInfo.gameBgInfo ?? GameInfoBg.create(editGameInfo.id),
  );
}

class CreateGameInfoUseCase {
  const CreateGameInfoUseCase(this._gameInfoRepository);

  final IGameInfoRepository _gameInfoRepository;

  Future<void> call(EditGameInfoEntity editGameInfo) {
    return _gameInfoRepository.saveGameInfo(_genMapper(editGameInfo));
  }
}
