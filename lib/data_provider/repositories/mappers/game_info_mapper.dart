import 'package:hoyo_launcher/data_provider/data_source/local/database/database.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';

GameInfoEntity gameInfoDBToEntity(GameInfoDBModel model) {
  return GameInfoEntity(
    id: model.id,
    icon: model.icon,
    title: model.title,
    launchPath: model.launchPath,
    gameBgType: GameInfoBgType.fromString(model.gameBgType),
    createTime: model.createTime,
    updateTime: model.updateTime,
    backgroundStr: model.background,
  );
}

GameInfoEntity? gameInfoDBToEntityNullable(GameInfoDBModel? model) {
  if (model == null) {
    return null;
  }

  return gameInfoDBToEntity(model);
}

List<GameInfoEntity> gameInfoDBListToEntityList(List<GameInfoDBModel> list) {
  return list.map((GameInfoDBModel model) => gameInfoDBToEntity(model)).toList();
}

GameInfoDBModel gameInfoEntityToDB(GameInfoEntity entity) {
  return GameInfoDBModel(
    id: entity.id,
    icon: entity.icon,
    title: entity.title,
    launchPath: entity.launchPath,
    gameBgType: entity.gameBgType?.value,
    createTime: entity.createTime,
    updateTime: entity.updateTime,
    background: entity.getBackground()?.toJsonString(),
  );
}
