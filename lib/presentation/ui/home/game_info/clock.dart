import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/settings/entities/clock_config.dart';
import 'package:hoyo_launcher/presentation/gen/fonts.gen.dart';
import 'package:hoyo_launcher/presentation/notifiers/app_config/app_config_notifier.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_builder.dart';
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
    return ExBuilder<AppConfig>(
      valueListenable: appConfigNotifier,
      shouldRebuild: (AppConfig p, AppConfig n) => p.clockConfig != n.clockConfig,
      builder: (AppConfig config) {
        final ClockConfig clock = config.clockConfig;

        TextStyle _textStyle(double fontSize) {
          return TextStyle(
            fontSize: fontSize * clock.scale,
            color: _fluentTheme.activeColor,
            height: 1,
            fontFamily: FontFamily.bebasNeue,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(clock.blurX, clock.blurY),
                color: Color(clock.shadowColor),
                blurRadius: clock.blurRadius,
              ),
            ],
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Text(
              (clock.showSecond ? DateFormat('HH:mm:ss') : DateFormat('HH:mm')).format(_dateTime),
              style: _textStyle(74),
            ),
            Positioned(
              bottom: -20 * clock.scale,
              right: 0,
              child: DefaultTextStyle(
                style: _textStyle(20),
                child: Row(
                  children: <Widget>[
                    Text(DateFormat('EEEE').format(_dateTime)),
                    Text(clock.dateIcon),
                    Text(DateFormat('dd/MM/yyy').format(_dateTime)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
