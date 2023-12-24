import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/commons/getIt/di.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/domain/game/usecases/update_game_info_usecase.dart';
import 'package:hoyo_launcher/presentation/ui/home/nav_bar.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';
import 'package:hoyo_launcher/presentation/utils/safe_state.dart';
import 'package:hoyo_launcher/presentation/widgets/app_btn.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/confirm_dialog.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';

import 'loop_image_box.dart';

class GameBgBuilder extends StatefulWidget {
  const GameBgBuilder({super.key, required this.gameInfo});

  final GameInfoEntity gameInfo;

  @override
  State<GameBgBuilder> createState() => _GameBgBuilderState();
}

class _GameBgBuilderState extends State<GameBgBuilder> with SafeState<GameBgBuilder> {
  final List<String> _images = <String>[];

  GameInfoEntity get _gameInfo => widget.gameInfo;

  @override
  void initState() {
    super.initState();
    _readyData();
  }

  @override
  void didUpdateWidget(covariant GameBgBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameInfo != widget.gameInfo || oldWidget.gameInfo.bgSameWith(widget.gameInfo.gameBgInfo)) {
      _readyData(update: true);
    }
  }

  void _readyData({bool update = false}) {
    _images.clear();

    final List<String> bgData = _gameInfo.gameBgInfo.bgData;

    bgData.removeWhere((String path) => path.trim().isEmpty);

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

  Future<void> _deleteImage(String path) async {
    if (path.startsWith('http')) {
      final bool confirmDel = await ConfirmDialog.show(l10n.confirm_del);
      if (!confirmDel) return;

      final GameInfoBg gameInfoBg = _gameInfo.gameBgInfo;
      gameInfoBg.bgData.remove('$path\n');
      final GameInfoEntity newInfo = _gameInfo.copyWith(gameBgInfo: gameInfoBg);
      getIt.get<UpdateGameInfoUseCase>().call(newInfo);
    } else {
      final bool confirmDel = await ConfirmDialog.show(l10n.confirm_del_file);
      if (!confirmDel) return;
      File(path).delete();

      _readyData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<String>(_gameInfo.id),
        child: _gameBgBuilder(context, _gameInfo),
      ),
    );
  }

  Widget _gameBgBuilder(BuildContext context, GameInfoEntity info) {
    if (_images.isEmpty) return _buildNullBg(context, info.icon);
    if (_images.length == 1) return SizedBox.expand(child: AppImg.cover(url: _images.first));

    final GameInfoBg gameInfoBg = info.gameBgInfo;

    return RepaintBoundary(
      child: LoopImageBox(
        interval: gameInfoBg.duration,
        animateDuration: gameInfoBg.animatDuratuion,
        children: _images.map(_buildImg).toList(),
      ),
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

  Widget _buildImg(String url) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        SizedBox.expand(child: AppImg.cover(url: url)),
        Padding(
          padding: const EdgeInsets.all(40.0).copyWith(left: 40 + NavBar.navBarMinWidth),
          child: AppBtn(
            onTap: () => _deleteImage(url),
            width: 40,
            height: 40,
            color: Colors.white.withOpacity(0.1),
            child: Icon(FluentIcons.delete, color: Colors.black.withOpacity(0.4)),
          ),
        ),
      ],
    );
  }
}
