import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/create_game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

import 'icon_selector.dart';

class CreateGameInfoPage extends StatefulWidget {
  const CreateGameInfoPage._();

  static Future<void> open() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const CreateGameInfoPage._(),
    );
  }

  @override
  State<CreateGameInfoPage> createState() => _CreateGameInfoPageState();
}

class _CreateGameInfoPageState extends State<CreateGameInfoPage> {
  EditGameInfoEntity _editInfo = EditGameInfoEntity.create(
    DateTime.now().millisecondsSinceEpoch.toString(),
  );

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: const Text('Delete file permanently?'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconSelector(onSelected: (String iconPath) => _editInfo.copyWith(icon: iconPath)),
          const SizedBox(height: 20),
          InfoLabel(
            label: l10n.game_name.withColon,
            child: TextBox(onChanged: (String value) => _editInfo = _editInfo.copyWith(title: value)),
          ),
          const SizedBox(height: 20),
          PathPicker(
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
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.pop(context, 'User deleted file');
                  // Delete file here
                },
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 150,
              child: FilledButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, 'User canceled dialog'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
