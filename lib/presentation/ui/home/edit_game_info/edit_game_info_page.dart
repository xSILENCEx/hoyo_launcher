import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/edit_game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_action.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/create_game_info_usecase.dart';
import 'package:hoyo_launcher/domain/game/usecases/del_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/ui/home/edit_game_info/edit_game_bg_box.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_list.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/confirm_dialog.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';
import 'package:hoyo_launcher/presentation/widgets/smooth_scroll_view.dart';

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
    final bool confirmDel = await ConfirmDialog.show(
      l10n.confirm_del,
      contentWidget: Text(gameInfo.title),
    );
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

  Future<void> _save(BuildContext context) async {
    try {
      if (_editInfo.icon.isNullOrEmpty) {
        AppInfoBar.show(context, l10n.plz_select_game_icon);
        return;
      }

      if (_editInfo.title.isNullOrEmpty) {
        AppInfoBar.show(context, l10n.plz_fill_game_name);
        return;
      }

      if (_editInfo.launchPath.isNullOrEmpty) {
        AppInfoBar.show(context, l10n.plz_fill_execution_path);
        return;
      }

      final DateTime now = DateTime.now();

      if (_editInfo.createTime == null) {
        _editInfo = _editInfo.copyWith(createTime: now);
      }
      _editInfo = _editInfo.copyWith(updateTime: now);

      await getIt.get<CreateGameInfoUseCase>()(_editInfo);
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onLaunchPathChanged(String path) async {
    if (_editInfo.launchPath == path) return;

    _editInfo = _editInfo.copyWith(launchPath: path);

    try {
      // 当前文件所在的上一个文件夹路径
      final List<String> pathList = path.split(r'\');
      pathList.removeLast();
      pathList.removeLast();
      final String dirPath = pathList.join(r'\');

      // 文件夹
      final Directory dir = Directory(dirPath);

      // 扫描 launcher.exe
      final List<FileSystemEntity> files = dir.listSync();
      final FileSystemEntity? launcherFile = files.firstWhereOrNull(
        (FileSystemEntity file) => file.path.endsWith('launcher.exe'),
      );
      final List<GameInfoAction> actions = List<GameInfoAction>.from(_editInfo.moreActions);

      if (launcherFile != null) {
        final GameInfoAction launcherAction = GameInfoAction(name: l10n.open_launcher, executePath: launcherFile.path);
        if (!actions.contains(launcherAction)) {
          actions.add(launcherAction);
        }
      }

      // 扫描 uninstall.exe
      final FileSystemEntity? uninstallFile = files.firstWhereOrNull(
        (FileSystemEntity file) => file.path.endsWith('uninstall.exe'),
      );
      if (uninstallFile != null) {
        final GameInfoAction uninstallAction = GameInfoAction(
          name: l10n.uninstall_game,
          executePath: uninstallFile.path,
        );
        if (!actions.contains(uninstallAction)) {
          actions.add(uninstallAction);
        }
      }

      if (actions.length != _editInfo.moreActions.length) {
        _editInfo = _editInfo.copyWith(moreActions: actions);
        setState(() {});
      }
    } catch (e) {
      AppInfoBar.show(context, e.toString(), severity: InfoBarSeverity.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: Text(widget.editGameInfo == null ? l10n.create_info : l10n.edit),
      content: SmoothScrollView(
        child: Column(
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
              onPathChanged: _onLaunchPathChanged,
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
                onPressed: () => _save(context),
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
