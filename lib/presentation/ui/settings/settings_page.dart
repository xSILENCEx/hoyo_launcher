import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/router_tool.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._();

  static Future<void> open() async {
    await showDialog(
      context: currentContext,
      builder: (_) => const SettingsPage._(),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ContentDialog();
  }
}
