import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/gen/fonts.gen.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer? _timer;

  DateTime _dateTime = DateTime.now();

  FluentThemeData get _fluentTheme => FluentTheme.of(context);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) {
        final DateTime now = DateTime.now();
        final DateTime nowSecond = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
        if (_dateTime != nowSecond) {
          _dateTime = nowSecond;
          setState(() {});
        }
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle(double fontSize) {
      return TextStyle(
        fontSize: fontSize,
        color: _fluentTheme.activeColor,
        height: 1,
        fontFamily: FontFamily.bebasNeue,
        shadows: <Shadow>[
          Shadow(offset: const Offset(1, 1), color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 40, top: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Text(DateFormat('HH:mm:ss').format(_dateTime), style: _textStyle(74)),
          Positioned(
            bottom: -30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(DateFormat('EEEE').format(_dateTime), style: _textStyle(26)),
                const SizedBox(width: 10),
                Text(DateFormat('dd/MM/yyy').format(_dateTime), style: _textStyle(26)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
