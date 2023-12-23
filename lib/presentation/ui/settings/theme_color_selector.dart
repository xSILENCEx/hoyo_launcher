import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

class ThemeColorSelector extends StatefulWidget {
  const ThemeColorSelector({
    required this.onThemeColorChanged,
    super.key,
    this.initUseSystemAccentColor,
    this.initDarkAccentColor,
    this.initLightAccentColor,
  });

  final bool? initUseSystemAccentColor;
  final Color? initDarkAccentColor;
  final Color? initLightAccentColor;

  final Function(bool useSystemAccentColor, Color darkAccentColor, Color lightAccentColor) onThemeColorChanged;

  @override
  State<ThemeColorSelector> createState() => _ThemeColorSelectorState();
}

class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  late bool _useSystemAccentColor = widget.initUseSystemAccentColor ?? true;
  late Color _darkAccentColor = widget.initDarkAccentColor ?? Colors.blue;
  late Color _lightAccentColor = widget.initLightAccentColor ?? Colors.blue;

  void _onThemeColorChanged(bool useSystemAccentColor) {
    if (useSystemAccentColor == _useSystemAccentColor) {
      return;
    }

    setState(() {
      _useSystemAccentColor = useSystemAccentColor;
    });

    widget.onThemeColorChanged(_useSystemAccentColor, _darkAccentColor, _lightAccentColor);
  }

  Future<void> _selectColor(bool isLight) async {
    final Color? color = await showDialog<Color>(
      context: context,
      builder: (_) => _buildColorPicker(context, isLight ? _lightAccentColor : _darkAccentColor),
    );

    if (color == null) {
      return;
    }

    if (isLight) {
      if (color == _lightAccentColor) return;
      _lightAccentColor = color;
    } else {
      if (color == _darkAccentColor) return;
      _darkAccentColor = color;
    }

    setState(() {});

    widget.onThemeColorChanged(_useSystemAccentColor, _darkAccentColor, _lightAccentColor);
  }

  @override
  Widget build(BuildContext context) {
    final fu.FluentThemeData fluentTheme = fu.FluentTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 32,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: fluentTheme.accentColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildBtn(true, l10n.follow_system, fluentTheme),
              _buildBtn(false, l10n.custom_color, fluentTheme),
            ],
          ),
        ),
        if (!_useSystemAccentColor)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildColorBtn(l10n.light, _lightAccentColor, () => _selectColor(true)),
                const SizedBox(width: 20),
                _buildColorBtn(l10n.dark, _darkAccentColor, () => _selectColor(false)),
              ],
            ),
          )
      ],
    );
  }

  Widget _buildBtn(bool value, String text, fu.FluentThemeData themeData) {
    return Material(
      color: _useSystemAccentColor == value ? themeData.accentColor : Colors.transparent,
      child: InkWell(
        onTap: () => _onThemeColorChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: _useSystemAccentColor == value ? themeData.scaffoldBackgroundColor : themeData.accentColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorBtn(String text, Color color, Function()? onTap) {
    return Row(
      children: <Widget>[
        Text(text.withColon),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 90,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
            child: Text(
              '#${color.value.toRadixString(16).toUpperCase()}',
              style: TextStyle(
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context, Color initColor) {
    Color color = initColor;

    return fu.ContentDialog(
      content: Material(
        color: Colors.transparent,
        child: ColorPicker(
          color: color,
          onChanged: (Color value) => color = value,
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: 150,
          child: fu.Button(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ),
        SizedBox(
          width: 150,
          child: fu.FilledButton(
            onPressed: () => Navigator.pop(context, color),
            child: Text(l10n.ok),
          ),
        ),
      ],
    );
  }
}
