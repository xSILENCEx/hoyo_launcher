import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/safe_state.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/loop_widget_box.dart';

class GameBgBuilder extends StatefulWidget {
  const GameBgBuilder({super.key, required this.gameInfo});

  final GameInfoEntity? gameInfo;

  @override
  State<GameBgBuilder> createState() => _GameBgBuilderState();
}

class _GameBgBuilderState extends State<GameBgBuilder> with SafeState<GameBgBuilder> {
  final List<String> _images = <String>[];

  GameInfoEntity? get _gameInfo => widget.gameInfo;

  @override
  void initState() {
    super.initState();
    _readyData();
  }

  @override
  void didUpdateWidget(covariant GameBgBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameInfo != widget.gameInfo) {
      _readyData(update: true);
    }
  }

  void _readyData({bool update = false}) {
    _images.clear();

    final GameInfoBg? gameInfoBg = _gameInfo?.gameBgInfo;
    if (gameInfoBg == null) return;

    final List<String> bgData = gameInfoBg.bgData;

    for (final String path in bgData) {
      // 有后缀的文件为图片，直接加入 _images ,使用正则匹配
      if (RegExp(r'\.(png|jpe?g|gif|webp|bmp|wbmp|heic|heif|tiff|raw|svg|ico)$', caseSensitive: false).hasMatch(path)) {
        _images.add(path);
      } else {
        // 没有后缀的文件为文件夹，遍历文件夹下的图片
        _images.addAll(_scanImage(path));
      }
    }

    if (_images.isNotEmpty && update) {
      safeSetState(() {});
    }
  }

  List<String> _scanImage(String folder) {
    final List<String> _imageList = <String>[];
    try {
      final Directory directory = Directory(folder);
      final List<FileSystemEntity> files = directory.listSync();
      for (final FileSystemEntity file in files) {
        if (file is File) {
          _imageList.add(file.path);
        }
      }
    } catch (e) {
      AppInfoBar.show(context, 'content');
    }

    return _imageList;
  }

  @override
  Widget build(BuildContext context) {
    final GameInfoEntity? innerGameInfo = _gameInfo;

    if (innerGameInfo == null) return Container(color: Colors.black.withOpacity(0.2));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<String>(innerGameInfo.id),
        child: _gameBgBuilder(context, innerGameInfo),
      ),
    );
  }

  Widget _gameBgBuilder(BuildContext context, GameInfoEntity info) {
    if (_images.isEmpty) return _buildNullBg(context, info.icon);
    if (_images.length == 1) return SizedBox.expand(child: AppImg.cover(url: _images.first));

    final GameInfoBg gameInfoBg = info.gameBgInfo;

    return LoopWidgetBox(
      interval: gameInfoBg.duration,
      animateDuration: gameInfoBg.animatDuratuion,
      children: _images.map((String url) => SizedBox.expand(child: AppImg.cover(url: url))).toList(),
    );
  }

  Widget _buildNullBg(BuildContext context, String icon) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    return Stack(
      children: <Widget>[
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: SizedBox.expand(child: AppImg.cover(url: icon)),
        ),
        Positioned.fill(child: ColoredBox(color: fluentTheme.scaffoldBackgroundColor.withOpacity(0.2))),
      ],
    );
  }
}
