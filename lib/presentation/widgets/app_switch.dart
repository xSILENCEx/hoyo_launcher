import 'package:fluent_ui/fluent_ui.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({super.key, required this.value, required this.onValueChanged});

  final bool value;
  final Function(bool value) onValueChanged;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late bool _value = widget.value;

  void _onValueChanged(bool value) {
    if (value == _value) {
      return;
    }

    setState(() {
      _value = value;
    });

    widget.onValueChanged(value);
  }

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != _value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Center(
        widthFactor: 1,
        child: ToggleSwitch(
          checked: _value,
          onChanged: _onValueChanged,
        ),
      ),
    );
  }
}
