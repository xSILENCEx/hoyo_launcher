import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';

abstract class ISettingsRepository {
  SettingsEntity getSettings();

  void updateSettings(SettingsEntity settings);
}
