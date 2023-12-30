import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/get_game_info_usecase.dart';
import 'package:hoyo_launcher/domain/game/usecases/update_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/ui/home/home.dart';

mixin GameInfoDataMixin on State<Home> {
  List<GameInfoEntity> gameInfoList = <GameInfoEntity>[];

  StreamSubscription<List<GameInfoEntity>>? _gameInfoListSubscription;

  @override
  void initState() {
    super.initState();
    _gameInfoListSubscription = getIt.get<GetGameInfoUseCase>().watchGameInfoList().listen(_listen);
  }

  @override
  void dispose() {
    _gameInfoListSubscription?.cancel();
    super.dispose();
  }

  void _listen(List<GameInfoEntity> data) {
    gameInfoList = data;
    setState(() {});
  }

  void onReorder(int fromIndex, int toIndex) {
    GameInfoEntity fromItem = gameInfoList[fromIndex];
    final GameInfoEntity toItem = gameInfoList[toIndex];

    if (toIndex == 0) {
      // 移动到第一个
      fromItem = fromItem.copyWith(sortValue: toItem.sortValue - 10000);
    } else if (toIndex == gameInfoList.length - 1) {
      // 移动到最后一个
      fromItem = fromItem.copyWith(sortValue: toItem.sortValue + 10000);
    } else if (fromIndex > toIndex) {
      // 向上移动
      final GameInfoEntity upItem = gameInfoList[toIndex - 1];
      fromItem = fromItem.copyWith(sortValue: (upItem.sortValue + toItem.sortValue) ~/ 2);
    } else {
      // 向下移动
      final GameInfoEntity downItem = gameInfoList[toIndex + 1];
      fromItem = fromItem.copyWith(sortValue: (downItem.sortValue + toItem.sortValue) ~/ 2);
    }

    gameInfoList.removeAt(fromIndex);
    gameInfoList.insert(toIndex, fromItem);

    setState(() {});

    getIt.get<UpdateGameInfoUseCase>()(fromItem);
  }
}
