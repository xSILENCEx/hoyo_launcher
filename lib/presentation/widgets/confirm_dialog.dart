import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog._({required this.content, this.contentWidth});

  final String content;

  final Widget? contentWidth;

  static Future<bool> show(String content, {Widget? contentWidth}) async {
    return await showDialog<bool>(
          context: currentContext,
          builder: (_) => ConfirmDialog._(content: content, contentWidth: contentWidth),
          barrierDismissible: true,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(l10n.confirm_delete),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(content),
          if (contentWidth != null) contentWidth!,
        ],
      ),
      actions: <Widget>[
        Button(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.no),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}
