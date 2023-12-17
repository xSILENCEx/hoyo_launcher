import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog._({required this.content});

  final String content;

  static Future<bool> show(String content) async {
    return await showDialog<bool>(
          context: currentContext,
          builder: (_) => ConfirmDialog._(content: content),
          barrierDismissible: true,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(l10n.confirm_delete),
      content: Text(content),
      actions: <Widget>[
        Button(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.no),
        ),
        Button(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}
