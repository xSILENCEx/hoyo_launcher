import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({required this.onColorChanged, super.key, this.color});

  final Color? color;

  final Function(Color color) onColorChanged;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color _color = widget.color ?? Colors.blue;

  Future<void> _selectColor() async {
    final Color? color = await showDialog<Color>(
      context: context,
      builder: (_) => _buildColorPicker(context, _color),
    );

    if (color == null) {
      return;
    }

    if (color == _color) return;
    _color = color;

    setState(() {});

    widget.onColorChanged(_color);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectColor,
      child: Container(
        width: 90,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _color),
        child: Text(
          '0X${_color.value.toRadixString(16).toUpperCase()}',
          style: TextStyle(
            color: _color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
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
