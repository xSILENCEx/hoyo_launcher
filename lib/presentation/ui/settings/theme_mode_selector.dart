import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

extension _ExThemeMode on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.system:
        return l10n.follow_system;
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
    }
  }
}

class ThemeModeSelector extends StatefulWidget {
  const ThemeModeSelector({
    super.key,
    required this.onThemeModeChanged,
    this.initThemeMode,
  });

  final ThemeMode? initThemeMode;
  final Function(ThemeMode themeMode) onThemeModeChanged;

  @override
  State<ThemeModeSelector> createState() => _ThemeModeSelectorState();
}

class _ThemeModeSelectorState extends State<ThemeModeSelector> {
  late ThemeMode _themeMode = widget.initThemeMode ?? ThemeMode.system;

  void _onThemeModeChanged(ThemeMode themeMode) {
    if (themeMode == _themeMode) {
      return;
    }

    setState(() {
      _themeMode = themeMode;
    });

    widget.onThemeModeChanged(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    final fu.FluentThemeData fluentTheme = fu.FluentTheme.of(context);

    return Container(
      height: 32,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: fluentTheme.accentColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map(
          (ThemeMode themeMode) {
            return Material(
              color: _themeMode == themeMode ? fluentTheme.accentColor : Colors.transparent,
              child: InkWell(
                onTap: () => _onThemeModeChanged(themeMode),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    themeMode.name,
                    style: TextStyle(
                      color: _themeMode == themeMode ? fluentTheme.scaffoldBackgroundColor : fluentTheme.accentColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
