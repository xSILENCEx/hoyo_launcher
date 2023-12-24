import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';
import 'package:hoyo_launcher/domain/settings/i_settings_repository.dart';

class SettingsUsecase {
  const SettingsUsecase(this._settingsRepository);

  final ISettingsRepository _settingsRepository;

  SettingsEntity getSettings() => _settingsRepository.getSettings();

  void updateSettings(SettingsEntity settings) => _settingsRepository.updateSettings(settings);

  String getVersion() => _settingsRepository.getVersion();
}
