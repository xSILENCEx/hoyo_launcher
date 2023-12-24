import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/settings/entities/clock_config.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

import 'color_selector.dart';

class ClockEditer extends StatefulWidget {
  const ClockEditer({super.key, required this.initClockConfig, required this.onShowClockChanged});

  final ClockConfig initClockConfig;
  final Function(ClockConfig config) onShowClockChanged;

  @override
  State<ClockEditer> createState() => _ClockEditerState();
}

class _ClockEditerState extends State<ClockEditer> {
  late ClockConfig _clockConfig = widget.initClockConfig;

  late final TextEditingController _textEditingController = TextEditingController(text: _clockConfig.dateIcon);

  void _onShowClockChanged(bool showClock) {
    if (showClock == _clockConfig.showClock) {
      return;
    }

    setState(() {
      _clockConfig = _clockConfig.copyWith(showClock: showClock);
    });

    widget.onShowClockChanged(_clockConfig);
  }

  void _onBlurOffsetChanged(double value, bool isX) {
    if (isX) {
      _clockConfig = _clockConfig.copyWith(blurX: value);
    } else {
      _clockConfig = _clockConfig.copyWith(blurY: value);
    }

    setState(() {});

    widget.onShowClockChanged(_clockConfig);
  }

  void _onBlurRadiusChanged(double value) {
    _clockConfig = _clockConfig.copyWith(blurRadius: value);

    setState(() {});

    widget.onShowClockChanged(_clockConfig);
  }

  void _onColorChanged(Color color) {
    _clockConfig = _clockConfig.copyWith(shadowColor: color.value);

    setState(() {});

    widget.onShowClockChanged(_clockConfig);
  }

  void _onDateIconChanged(String value) {
    _clockConfig = _clockConfig.copyWith(dateIcon: value);

    setState(() {});

    widget.onShowClockChanged(_clockConfig);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ClockEditer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initClockConfig != _clockConfig) {
      _clockConfig = widget.initClockConfig;
      _textEditingController.text = _clockConfig.dateIcon;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 32,
          alignment: Alignment.centerRight,
          child: ToggleSwitch(
            checked: _clockConfig.showClock,
            onChanged: _onShowClockChanged,
          ),
        ),
        if (_clockConfig.showClock)
          SizedBox(
            width: 380,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                _moreConfigItem(
                  l10n.shadow_color,
                  ColorSelector(
                    color: Color(_clockConfig.shadowColor),
                    onColorChanged: _onColorChanged,
                  ),
                ),
                const SizedBox(height: 16),
                _moreConfigItem(
                  'Blur',
                  _BlurSlider(
                    onChanged: _onBlurRadiusChanged,
                    value: _clockConfig.blurRadius,
                    label: '${_clockConfig.blurRadius.toInt()}',
                    min: 0,
                    max: 30,
                  ),
                ),
                const SizedBox(height: 20),
                _moreConfigItem(
                  'Blur X',
                  _BlurSlider(
                    onChanged: (double v) => _onBlurOffsetChanged(v, true),
                    value: _clockConfig.blurX,
                    label: '${_clockConfig.blurX.toInt()}',
                  ),
                ),
                const SizedBox(height: 20),
                _moreConfigItem(
                  'Blur Y',
                  _BlurSlider(
                    onChanged: (double v) => _onBlurOffsetChanged(v, false),
                    value: _clockConfig.blurY,
                    label: '${_clockConfig.blurY.toInt()}',
                  ),
                ),
                const SizedBox(height: 10),
                _moreConfigItem(
                  l10n.date_text,
                  SizedBox(
                    width: 200,
                    child: TextBox(
                      controller: _textEditingController,
                      onChanged: _onDateIconChanged,
                      maxLength: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _moreConfigItem(String text, Widget content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text.withColon),
        content,
      ],
    );
  }
}

class _BlurSlider extends StatelessWidget {
  const _BlurSlider({
    this.onChanged,
    required this.value,
    this.label,
    this.min = -50,
    this.max = 50,
  });

  final void Function(double)? onChanged;
  final double value;
  final String? label;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    final FluentThemeData _fluentTheme = FluentTheme.of(context);

    return Slider(
      onChanged: onChanged,
      value: value,
      label: label,
      min: min,
      max: max,
      style: SliderThemeData(labelBackgroundColor: _fluentTheme.accentColor),
    );
  }
}
