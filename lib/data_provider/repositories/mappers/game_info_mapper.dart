import 'package:hoyo_launcher/data_provider/data_source/local/database/database.dart';
import 'package:hoyo_launcher/data_provider/data_source/local/database/models/full_game_info_db_model.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';

GameInfoBg gameInfoBgDBToEntity(GameInfoBgDBModel model) {
  return GameInfoBg(
    id: model.id,
    interval: Duration(seconds: model.duration),
    animateDuration: Duration(milliseconds: model.animatDuratuion),
    random: model.random ?? true,
    bgData: model.bgData.split(','),
  );
}

GameInfoEntity gameInfoDBToEntity(FullGameInfoDBModel model) {
  return GameInfoEntity(
    id: model.gameInfoDBModel.id,
    icon: model.gameInfoDBModel.icon,
    title: model.gameInfoDBModel.title,
    launchPath: model.gameInfoDBModel.launchPath,
    createTime: model.gameInfoDBModel.createTime,
    updateTime: model.gameInfoDBModel.updateTime,
    sortValue: model.gameInfoDBModel.sortValue ?? 0,
    moreActionsStr: model.gameInfoDBModel.moreActions,
    gameBgInfo: gameInfoBgDBToEntity(model.gameInfoBgDBModel),
  );
}

GameInfoEntity? gameInfoDBToEntityNullable(FullGameInfoDBModel? model) {
  if (model == null) return null;
  return gameInfoDBToEntity(model);
}

List<GameInfoEntity> gameInfoDBListToEntityList(List<FullGameInfoDBModel> list) {
  return list.map(gameInfoDBToEntity).toList();
}

GameInfoBgDBModel gameInfoBgEntityToDB(GameInfoBg entity) {
  return GameInfoBgDBModel(
    id: entity.id,
    duration: entity.interval.inSeconds,
    animatDuratuion: entity.animateDuration.inMilliseconds,
    random: entity.random,
    bgData: entity.bgData.join(','),
  );
}

FullGameInfoDBModel gameInfoEntityToDB(GameInfoEntity entity) {
  return FullGameInfoDBModel(
    GameInfoDBModel(
      id: entity.id,
      icon: entity.icon,
      title: entity.title,
      launchPath: entity.launchPath,
      createTime: entity.createTime,
      updateTime: entity.updateTime,
      sortValue: entity.sortValue,
      moreActions: entity.genMoreActionsStr(),
    ),
    gameInfoBgEntityToDB(entity.gameBgInfo),
  );
}
