import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/edit_game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_action.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/create_game_info_usecase.dart';
import 'package:hoyo_launcher/domain/game/usecases/del_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/ui/home/edit_game_info/edit_game_bg_box.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/confirm_dialog.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

import 'edit_more_actions_box.dart';
import 'icon_selector.dart';

EditGameInfoEntity _resolveMapper(GameInfoEntity editGameInfo) {
  return EditGameInfoEntity.edit(
    id: editGameInfo.id,
    icon: editGameInfo.icon,
    title: editGameInfo.title,
    launchPath: editGameInfo.launchPath,
    createTime: editGameInfo.createTime,
    updateTime: editGameInfo.updateTime,
    moreActions: editGameInfo.moreActions,
    gameBgInfo: editGameInfo.gameBgInfo,
  );
}

class EditGameInfoPage extends StatefulWidget {
  const EditGameInfoPage._({this.editGameInfo});

  final EditGameInfoEntity? editGameInfo;

  static Future<void> create() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const EditGameInfoPage._(),
      barrierDismissible: true,
    );
  }

  static Future<void> edit(GameInfoEntity gameInfo) async {
    await showDialog(
      context: currentContext,
      builder: (_) => EditGameInfoPage._(editGameInfo: _resolveMapper(gameInfo)),
      barrierDismissible: true,
    );
  }

  static Future<void> del(GameInfoEntity gameInfo) async {
    final bool confirmDel = await ConfirmDialog.show(gameInfo.title);
    if (confirmDel) {
      await getIt.get<DelGameInfoUsecase>()(gameInfo.id);
    }
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

    await getIt.get<CreateGameInfoUseCase>()(_editInfo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: Text(widget.editGameInfo == null ? l10n.create_info : l10n.edit),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconSelector(
            initIconPath: _editInfo.icon,
            onSelected: (String iconPath) => _editInfo = _editInfo.copyWith(icon: iconPath),
          ),
          _spacer(),
          InfoLabel(
            label: l10n.game_name.withColon,
            child: Padding(
              padding: const EdgeInsets.only(right: 120),
              child: TextFormBox(
                initialValue: _editInfo.title,
                onChanged: (String value) => _editInfo = _editInfo.copyWith(title: value),
                maxLength: 4000,
              ),
            ),
          ),
          _spacer(),
          PathPicker(
            initialPath: _editInfo.launchPath,
            headerValue: l10n.launch_path.withColon,
            pickType: PickType.file,
            onPathChanged: (String path) => _editInfo = _editInfo.copyWith(launchPath: path),
          ),
          _spacer(),
          EditMoreActionsBox(
            initActions: _editInfo.moreActions,
            onActionsChanged: (List<GameInfoAction> actions) => _editInfo = _editInfo.copyWith(moreActions: actions),
          ),
          _spacer(),
          EditGameBgBox(
            id: _editInfo.id,
            initGameInfoBg: _editInfo.gameBgInfo,
            onGameInfoBgChanged: (GameInfoBg gameInfoBg) => _editInfo = _editInfo.copyWith(gameBgInfo: gameInfoBg),
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
                child: Text(l10n.ok),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _spacer() {
    return const SizedBox(height: 20);
  }
}
