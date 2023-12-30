import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg.dart';
import 'package:hoyo_launcher/presentation/utils/ex_types/ex_string.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/widgets/app_switch.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';

const double _minInterval = 5;
const double _maxInterval = 60;

const double _minAnimateDuration = 200;
const double _maxAnimateDuration = 1000;

class EditGameBgBox extends StatefulWidget {
  const EditGameBgBox({
    super.key,
    required this.id,
    required this.onGameInfoBgChanged,
    this.initGameInfoBg,
  });

  final String id;
  final GameInfoBg? initGameInfoBg;

  final Function(GameInfoBg gameInfoBg) onGameInfoBgChanged;

  @override
  State<EditGameBgBox> createState() => _EditGameBgBoxState();
}

class _EditGameBgBoxState extends State<EditGameBgBox> {
  late final TextEditingController _editingController;

  late GameInfoBg _gameInfoBg = widget.initGameInfoBg ?? GameInfoBg.create(widget.id);

  bool _isSelecting = false;

  FluentThemeData get _fluentTheme => FluentTheme.of(context);

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: _gameInfoBg.bgData.join('\n'));
    _init();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _init() {
    if (_gameInfoBg.interval.inSeconds < _minInterval) {
      _gameInfoBg = _gameInfoBg.copyWith(interval: Duration(seconds: _minInterval.toInt()));
    } else if (_gameInfoBg.interval.inSeconds > _maxInterval) {
      _gameInfoBg = _gameInfoBg.copyWith(interval: Duration(seconds: _maxInterval.toInt()));
    }

    if (_gameInfoBg.animateDuration.inMilliseconds < _minAnimateDuration) {
      _gameInfoBg = _gameInfoBg.copyWith(animateDuration: Duration(milliseconds: _minAnimateDuration.toInt()));
    } else if (_gameInfoBg.animateDuration.inMilliseconds > _maxAnimateDuration) {
      _gameInfoBg = _gameInfoBg.copyWith(animateDuration: Duration(milliseconds: _maxAnimateDuration.toInt()));
    }
  }

  Future<void> _addPath({bool isFolder = false}) async {
    String? path;

    try {
      if (_isSelecting) return;
      _isSelecting = true;
      if (isFolder) {
        path = await FilePicker.platform.getDirectoryPath();
      } else {
        final FilePickerResult? result = await FilePicker.platform.pickFiles();
        path = result?.files.single.path;
      }
    } catch (e) {
      AppInfoBar.show(
        context,
        e.toString(),
        severity: InfoBarSeverity.error,
      );
    } finally {
      _isSelecting = false;
    }

    if (path == null) return;

    final List<String> paths = _editingController.text.split('\n');

    paths.removeWhere((String element) => element.trim().isEmpty);

    if (paths.contains(path)) {
      AppInfoBar.show(context, l10n.path_already_exists);
      return;
    }

    paths.add(path);

    _editingController.text = paths.join('\n');

    _onPathChanged(_editingController.text);
  }

  void _onPathChanged(String value) {
    final List<String> paths = value.split('\n');

    final List<String> validPaths = <String>[];

    for (final String path in paths) {
      if (path.trim().isNotEmpty) {
        validPaths.add(path);
      }
    }

    _gameInfoBg = _gameInfoBg.copyWith(bgData: validPaths);

    widget.onGameInfoBgChanged(_gameInfoBg);
  }

  void _onRandomChanged(bool value) {
    _gameInfoBg = _gameInfoBg.copyWith(random: value);
    widget.onGameInfoBgChanged(_gameInfoBg);
  }

  void _onIntervalChanged(double value) {
    _gameInfoBg = _gameInfoBg.copyWith(interval: Duration(seconds: value.toInt()));
    widget.onGameInfoBgChanged(_gameInfoBg);

    setState(() {});
  }

  void _onAnimateDurationChanged(double value) {
    _gameInfoBg = _gameInfoBg.copyWith(animateDuration: Duration(milliseconds: value.toInt()));
    widget.onGameInfoBgChanged(_gameInfoBg);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> placeholder = <String>[
      '(${l10n.net_image})  https://xxx.xxxxx.xxxx/xxxxxx.jpg',
      '(${l10n.local_image})  C:\\Users\\admin\\Pictures\\zzz.png',
      '(${l10n.folder})  C:\\Users\\admin\\Pictures\\Camera Roll'
    ];

    return Container(
      padding: const EdgeInsets.all(10).copyWith(bottom: 20),
      decoration: BoxDecoration(
        color: _fluentTheme.cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(l10n.bg_images.withColon),
              const Spacer(),
              Text(l10n.image_source.withColon, style: TextStyle(fontSize: 12, color: _fluentTheme.accentColor)),
              const SizedBox(width: 20),
              IconButton(onPressed: _addPath, icon: const Icon(FluentIcons.photo2_add)),
              IconButton(onPressed: () => _addPath(isFolder: true), icon: const Icon(FluentIcons.folder_open)),
            ],
          ),
          const Divider(style: DividerThemeData(horizontalMargin: EdgeInsets.symmetric(vertical: 10), thickness: 1)),
          TextBox(
            onChanged: _onPathChanged,
            placeholder: placeholder.join('\n'),
            placeholderStyle: TextStyle(color: _fluentTheme.inactiveColor.withOpacity(0.5)),
            controller: _editingController,
            maxLines: null,
            minLines: 3,
            decoration: BoxDecoration(
              color: _fluentTheme.menuColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.random_swich),
              AppSwitch(value: _gameInfoBg.random, onValueChanged: _onRandomChanged),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.swich_interval),
              _buildSlider(
                _gameInfoBg.interval.inSeconds,
                _minInterval,
                _maxInterval,
                onChanged: _onIntervalChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(l10n.animate_duration),
              _buildSlider(
                _gameInfoBg.animateDuration.inMilliseconds,
                _minAnimateDuration,
                _maxAnimateDuration,
                onChanged: _onAnimateDurationChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(int value, double min, double max, {required void Function(double)? onChanged}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Slider(
          onChanged: onChanged,
          min: min,
          max: max,
          value: value.toDouble(),
          label: value.toString(),
          style: SliderThemeData(labelBackgroundColor: _fluentTheme.accentColor, useThumbBall: true),
        ),
      ),
    );
  }
}
