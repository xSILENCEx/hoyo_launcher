import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog._({required this.content, this.contentWidget});

  final String content;

  final Widget? contentWidget;

  static Future<bool> show(String content, {Widget? contentWidget}) async {
    return await showDialog<bool>(
          context: currentContext,
          builder: (_) => ConfirmDialog._(content: content, contentWidget: contentWidget),
          barrierDismissible: true,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(content),
      content: contentWidget,
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
