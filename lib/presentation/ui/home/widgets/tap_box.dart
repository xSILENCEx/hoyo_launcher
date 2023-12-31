import 'package:flutter/material.dart';

class TapBox extends StatefulWidget {
  const TapBox({super.key, required this.child, required this.onTap});

  final Widget child;
  final Function() onTap;

  @override
  State<TapBox> createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox> {
  // String _currEvent = '';

  DateTime? _tapDownTime;

  void _onEventChanged(String event) {
    // print('_currEvent: $_currEvent | event: $event');

    if (event == 'onPointerDown') {
      _tapDownTime = DateTime.now();
    } else if (event == 'onPointerUp') {
      if (_tapDownTime != null) {
        final Duration duration = DateTime.now().difference(_tapDownTime!);
        if (duration.inMilliseconds < 100) {
          widget.onTap();
        }
      }
    }

    // _currEvent = event;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => _onEventChanged('onPointerDown'),
      onPointerUp: (_) => _onEventChanged('onPointerUp'),
      // onPointerCancel: (_) => _onEventChanged('onPointerCancel'),
      // onPointerMove: (_) => _onEventChanged('onPointerMove'),
      // onPointerHover: (_) => _onEventChanged('onPointerHover'),
      // onPointerSignal: (_) => _onEventChanged('onPointerSignal'),
      // onPointerPanZoomEnd: (_) => _onEventChanged('onPointerPanZoomEnd'),
      // onPointerPanZoomStart: (_) => _onEventChanged('onPointerPanZoomStart'),
      // onPointerPanZoomUpdate: (_) => _onEventChanged('onPointerPanZoomUpdate'),
      child: widget.child,
    );
  }
}
