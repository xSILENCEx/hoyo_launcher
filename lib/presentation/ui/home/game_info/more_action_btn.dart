import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_action.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreActionBtn extends StatelessWidget {
  const MoreActionBtn({
    super.key,
    required this.actions,
    required this.btnSize,
  });

  final List<GameInfoAction> actions;
  final double btnSize;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();

    final LayerLink _layerLink = LayerLink();

    Future<void> _onTap(BuildContext context, LayerLink layerLink) async {
      final String? executePath = await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.1),
        builder: (BuildContext context) {
          return _buildMenu(context, layerLink);
        },
      );

      if (executePath == null) return;

      launchUrlString(executePath);
    }

    return Container(
      width: btnSize,
      height: btnSize,
      margin: const EdgeInsets.only(left: 10),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: FilledButton(
          onPressed: () => _onTap(context, _layerLink),
          style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
          child: const Center(child: Icon(FluentIcons.collapse_menu)),
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, LayerLink layerLink) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    final ContentDialogThemeData style = ContentDialogThemeData.standard(fluentTheme).merge(fluentTheme.dialogTheme);

    final BoxDecoration? styleDecoration = style.decoration as BoxDecoration?;

    return CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, -btnSize * 1.2),
      targetAnchor: Alignment.bottomRight,
      followerAnchor: Alignment.bottomRight,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          constraints: BoxConstraints(
            minWidth: btnSize * 5 + 10,
            maxWidth: 300,
            maxHeight: 400,
          ),
          decoration: styleDecoration?.copyWith(
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: List<Widget>.generate(
                actions.length,
                (int i) {
                  return GestureDetector(
                    onTap: () => Navigator.pop(context, actions[i].executePath),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      constraints: BoxConstraints(minWidth: btnSize * 5 + 10),
                      height: btnSize,
                      child: HoverBuilder(builder: (bool isHover) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: ColoredBox(
                            color: isHover ? fluentTheme.cardColor : Colors.transparent,
                            child: Center(
                              widthFactor: 1,
                              child: Text(actions[i].name),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
