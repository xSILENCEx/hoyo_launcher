import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

class AppInfoBar extends StatelessWidget {
  const AppInfoBar._({
    required this.severity,
    required this.close,
    required this.content,
    this.icon,
    this.title,
  });
  final InfoBarSeverity severity;
  final void Function() close;

  final Widget? icon;
  final String? title;
  final String content;

  static Future<void> show(
    BuildContext context,
    String content, {
    Widget? icon,
    String? title,
    InfoBarSeverity severity = InfoBarSeverity.warning,
  }) async {
    await displayInfoBar(
      context,
      builder: (_, Function() close) {
        return AppInfoBar._(
          severity: severity,
          close: close,
          icon: icon,
          title: title,
          content: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoBar(
      title: Text(title ?? _defTitle),
      content: Text(content),
      action: IconButton(
        icon: icon ?? const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: InfoBarSeverity.warning,
    );
  }

  String get _defTitle {
    switch (severity) {
      case InfoBarSeverity.info:
        return l10n.info;
      case InfoBarSeverity.warning:
        return l10n.warning;
      case InfoBarSeverity.error:
        return l10n.error;
      case InfoBarSeverity.success:
        return l10n.success;
    }
  }
}
