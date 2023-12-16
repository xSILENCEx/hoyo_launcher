// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data_provider/repositories/game_info_repository.dart' as _i4;
import '../../domain/game/i_game_info_repository.dart' as _i3;
import '../../domain/game/usecases/create_game_info_usecase.dart' as _i6;
import '../../domain/game/usecases/del_game_info_usecase.dart' as _i7;
import '../../domain/game/usecases/get_game_info_usecase.dart' as _i8;
import '../../domain/game/usecases/update_game_info_usecase.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.IGameInfoRepository>(() => _i4.GameInfoRepository());
    gh.factory<_i5.UpdateGameInfoUseCase>(
        () => _i5.UpdateGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i6.CreateGameInfoUseCase>(
        () => _i6.CreateGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i7.DelGameInfoUsecase>(
        () => _i7.DelGameInfoUsecase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i8.GetGameInfoUseCase>(
        () => _i8.GetGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    return this;
  }
}
