import 'package:fluent_ui/fluent_ui.dart';

class ShowClockSwitch extends StatefulWidget {
  const ShowClockSwitch({super.key, this.initShowClock, required this.onShowClockChanged});

  final bool? initShowClock;
  final Function(bool showClock) onShowClockChanged;

  @override
  State<ShowClockSwitch> createState() => _ShowClockSwitchState();
}

class _ShowClockSwitchState extends State<ShowClockSwitch> {
  late bool _showClock = widget.initShowClock ?? true;

  void _onShowClockChanged(bool showClock) {
    if (showClock == _showClock) {
      return;
    }

    setState(() {
      _showClock = showClock;
    });

    widget.onShowClockChanged(showClock);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      checked: _showClock,
      onChanged: _onShowClockChanged,
    );
  }
}
