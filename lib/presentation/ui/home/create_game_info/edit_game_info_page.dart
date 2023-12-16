import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/commons/logger.dart';
import 'package:hoyo_launcher/domain/game/entities/create_game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/create_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

import 'icon_selector.dart';

EditGameInfoEntity _resolveMapper(GameInfoEntity editGameInfo) {
  return EditGameInfoEntity.edit(
    id: editGameInfo.id,
    icon: editGameInfo.icon,
    title: editGameInfo.title,
    launchPath: editGameInfo.launchPath,
    createTime: editGameInfo.createTime,
    updateTime: editGameInfo.updateTime,
    gameBgType: editGameInfo.gameBgType,
    background: editGameInfo.getBackground(),
    launcherPath: editGameInfo.launcherPath,
  );
}

class EditGameInfoPage extends StatefulWidget {
  const EditGameInfoPage._({this.editGameInfo});

  final EditGameInfoEntity? editGameInfo;

  static Future<void> create() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const EditGameInfoPage._(),
    );
  }

  static Future<void> edit(GameInfoEntity gameInfo) async {
    await showDialog(
      context: currentContext,
      builder: (_) => EditGameInfoPage._(editGameInfo: _resolveMapper(gameInfo)),
    );
  }

  @override
  State<EditGameInfoPage> createState() => _EditGameInfoPageState();
}

class _EditGameInfoPageState extends State<EditGameInfoPage> {
  late EditGameInfoEntity _editInfo = widget.editGameInfo ??
      EditGameInfoEntity.create(
        DateTime.now().millisecondsSinceEpoch.toString(),
      );

  Future<void> _save() async {
    final DateTime now = DateTime.now();

    if (_editInfo.createTime == null) {
      _editInfo = _editInfo.copyWith(createTime: now);
    }
    _editInfo = _editInfo.copyWith(updateTime: now);

    infoLog('_editInfo:${_editInfo.toJson()}');

    await getIt.get<CreateGameInfoUseCase>()(_editInfo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: const Text('Delete file permanently?'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconSelector(
            initIconPath: _editInfo.icon,
            onSelected: (String iconPath) => _editInfo = _editInfo.copyWith(icon: iconPath),
          ),
          const SizedBox(height: 20),
          InfoLabel(
            label: l10n.game_name.withColon,
            child: TextFormBox(
              initialValue: _editInfo.title,
              onChanged: (String value) => _editInfo = _editInfo.copyWith(title: value),
            ),
          ),
          const SizedBox(height: 20),
          PathPicker(
            initialPath: _editInfo.launchPath,
            headerValue: l10n.execution_path.withColon,
            pickType: PickType.file,
            onPathChanged: (String path) => _editInfo = _editInfo.copyWith(launchPath: path),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Button(
                child: Text(l10n.cancel),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: _save,
                child: Text(l10n.create_info),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
