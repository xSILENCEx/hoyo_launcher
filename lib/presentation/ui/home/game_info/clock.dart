import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer? _timer;

  DateTime _dateTime = DateTime.now();

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
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(right: 40, top: 40),
      child: ColoredBox(
        color: Colors.black,
        child: Text(
          DateFormat('HH:mm:ss').format(_dateTime),
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
