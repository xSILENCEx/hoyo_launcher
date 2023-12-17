import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_action.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/path_picker.dart';

class EditMoreActionsBox extends StatefulWidget {
  const EditMoreActionsBox({
    super.key,
    this.initActions = const <GameInfoAction>[],
    required this.onActionsChanged,
  });

  final List<GameInfoAction> initActions;
  final Function(List<GameInfoAction> actions) onActionsChanged;

  @override
  State<EditMoreActionsBox> createState() => _EditMoreActionsBoxState();
}

class _EditMoreActionsBoxState extends State<EditMoreActionsBox> {
  late final List<GameInfoAction> _actions = List<GameInfoAction>.from(widget.initActions);

  FluentThemeData get _fluentTheme => FluentTheme.of(context);

  Future<void> _addAcrion() async {
    final GameInfoAction? action = await showDialog<GameInfoAction>(
      context: context,
      builder: _addActionBox,
    );

    if (action == null) return;

    setState(() {
      _actions.add(action);
      widget.onActionsChanged(_actions);
    });
  }

  void _removeAction(int index) {
    setState(() {
      _actions.removeAt(index);
    });
    widget.onActionsChanged(_actions);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _fluentTheme.cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.more_actions.withColon),
              _buildAddBtn(),
            ],
          ),
          if (_actions.isNotEmpty)
            const Divider(
              style: DividerThemeData(
                horizontalMargin: EdgeInsets.symmetric(vertical: 10),
                thickness: 1,
              ),
            ),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _actions.length,
              itemBuilder: (BuildContext _, int index) => _buildItem(index, _actions[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index, GameInfoAction info) {
    return Row(
      children: <Widget>[
        SizedBox(width: 80, child: Text(info.name)),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            info.executePath,
            style: TextStyle(color: _fluentTheme.inactiveColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(FluentIcons.delete),
          onPressed: () => _removeAction(index),
        ),
      ],
    );
  }

  Widget _buildAddBtn() {
    return GestureDetector(
      onTap: _addAcrion,
      child: HoverBuilder(
        builder: (bool isHover) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHover ? _fluentTheme.accentColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(FluentIcons.add),
          );
        },
      ),
    );
  }

  Widget _addActionBox(BuildContext context) {
    String? title;
    String? path;

    return ContentDialog(
      constraints: kDefaultContentDialogConstraints.copyWith(maxWidth: 500),
      title: Text(l10n.add_action),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InfoLabel(
            label: l10n.action_name.withColon,
            child: TextBox(onChanged: (String value) => title = value),
          ),
          const SizedBox(height: 20),
          PathPicker(
            headerValue: l10n.execution_path.withColon,
            onPathChanged: (String value) => path = value,
            pickType: PickType.file,
          ),
        ],
      ),
      actions: <Widget>[
        Button(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        Button(
          onPressed: () {
            if (title.isNullOrBlank || path.isNullOrBlank) {
              AppInfoBar.show(context, l10n.plz_complete_info);
              return;
            }

            Navigator.pop(
              context,
              GameInfoAction(name: title!, executePath: path!),
            );
          },
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}
