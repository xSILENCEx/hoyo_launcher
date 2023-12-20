import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

const double _typeBtnHeight = 30;
const double _typeBtnWidth = 120;

class EditGameBgBox extends StatefulWidget {
  const EditGameBgBox({
    super.key,
    required this.onGameInfoBgChanged,
  });

  final Function(GameInfoBg gameInfoBg) onGameInfoBgChanged;

  @override
  State<EditGameBgBox> createState() => _EditGameBgBoxState();
}

class _EditGameBgBoxState extends State<EditGameBgBox> {
  final LayerLink _layerLink = LayerLink();

  FluentThemeData get _fluentTheme => FluentTheme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _fluentTheme.cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.bg_type.withColon),
              const SizedBox(width: 10),
            ],
          ),
          const Divider(
            style: DividerThemeData(
              horizontalMargin: EdgeInsets.symmetric(vertical: 16),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageListBox extends StatefulWidget {
  const _ImageListBox({required this.pathList, required this.onPathListChanged});

  final List<String> pathList;
  final Function(List<String> pathList) onPathListChanged;

  @override
  State<_ImageListBox> createState() => _ImageListBoxState();
}

class _ImageListBoxState extends State<_ImageListBox> {
  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: l10n.one_image_per_line,
      child: TextBox(
        onEditingComplete: () {},
        maxLength: 4000,
        maxLines: 2,
      ),
    );
  }
}
