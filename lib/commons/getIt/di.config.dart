// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data_provider/repositories/game_info_repository.dart' as _i618;
import '../../data_provider/repositories/settings_repository.dart' as _i455;
import '../../domain/game/i_game_info_repository.dart' as _i658;
import '../../domain/game/usecases/create_game_info_usecase.dart' as _i755;
import '../../domain/game/usecases/del_game_info_usecase.dart' as _i491;
import '../../domain/game/usecases/get_game_info_usecase.dart' as _i907;
import '../../domain/game/usecases/update_game_info_usecase.dart' as _i46;
import '../../domain/settings/i_settings_repository.dart' as _i914;
import '../../domain/settings/usecases/settings_usecase.dart' as _i969;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i914.ISettingsRepository>(() => _i455.SettingsRepository());
    gh.factory<_i658.IGameInfoRepository>(() => _i618.GameInfoRepository());
    gh.factory<_i755.CreateGameInfoUseCase>(
        () => _i755.CreateGameInfoUseCase(gh<_i658.IGameInfoRepository>()));
    gh.factory<_i491.DelGameInfoUsecase>(
        () => _i491.DelGameInfoUsecase(gh<_i658.IGameInfoRepository>()));
    gh.factory<_i907.GetGameInfoUseCase>(
        () => _i907.GetGameInfoUseCase(gh<_i658.IGameInfoRepository>()));
    gh.factory<_i46.UpdateGameInfoUseCase>(
        () => _i46.UpdateGameInfoUseCase(gh<_i658.IGameInfoRepository>()));
    gh.factory<_i969.SettingsUsecase>(
        () => _i969.SettingsUsecase(gh<_i914.ISettingsRepository>()));
    return this;
  }
}
