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
import '../../data_provider/repositories/settings_repository.dart' as _i6;
import '../../domain/game/i_game_info_repository.dart' as _i3;
import '../../domain/game/usecases/create_game_info_usecase.dart' as _i9;
import '../../domain/game/usecases/del_game_info_usecase.dart' as _i10;
import '../../domain/game/usecases/get_game_info_usecase.dart' as _i11;
import '../../domain/game/usecases/update_game_info_usecase.dart' as _i8;
import '../../domain/settings/i_settings_repository.dart' as _i5;
import '../../domain/settings/usecases/settings_usecase.dart' as _i7;

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
    gh.factory<_i5.ISettingsRepository>(() => _i6.SettingsRepository());
    gh.factory<_i7.SettingsUsecase>(
        () => _i7.SettingsUsecase(gh<_i5.ISettingsRepository>()));
    gh.factory<_i8.UpdateGameInfoUseCase>(
        () => _i8.UpdateGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i9.CreateGameInfoUseCase>(
        () => _i9.CreateGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i10.DelGameInfoUsecase>(
        () => _i10.DelGameInfoUsecase(gh<_i3.IGameInfoRepository>()));
    gh.factory<_i11.GetGameInfoUseCase>(
        () => _i11.GetGameInfoUseCase(gh<_i3.IGameInfoRepository>()));
    return this;
  }
}
