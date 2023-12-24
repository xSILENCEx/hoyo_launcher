import 'package:hoyo_launcher/data_provider/data_source/local/package/package_info_tools.dart';
import 'package:hoyo_launcher/data_provider/data_source/local/storage/local_storage.dart';
import 'package:hoyo_launcher/domain/settings/entities/settings_entity.dart';
import 'package:hoyo_launcher/domain/settings/i_settings_repository.dart';
import 'package:injectable/injectable.dart';

import 'mappers/settings_mapper.dart';

const String _settingsValueKey = 'settings';

@Injectable(as: ISettingsRepository)
class SettingsRepository implements ISettingsRepository {
  @override
  SettingsEntity getSettings() {
    final String? jsonStr = LocalStorage.getV<String>(_settingsValueKey);
    if (jsonStr == null) {
      return SettingsEntity.def();
    }

    return jsonStrToEntity(jsonStr);
  }

  @override
  void updateSettings(SettingsEntity settings) {
    LocalStorage.setV(_settingsValueKey, settings.toJsonString());
  }

  @override
  String getVersion() => PackageTool.getVersionStr();
}
