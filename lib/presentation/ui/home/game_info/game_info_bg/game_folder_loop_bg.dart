import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/rotation_folder_bg.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';
import 'package:hoyo_launcher/presentation/widgets/info_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/loop_widget_box.dart';

class GameFolderLoopBg extends StatefulWidget {
  const GameFolderLoopBg({super.key, required this.bgInfo});

  final RotationFolderBg? bgInfo;

  @override
  State<GameFolderLoopBg> createState() => _GameFolderLoopBgState();
}

class _GameFolderLoopBgState extends State<GameFolderLoopBg> {
  final List<String> _imageList = <String>[];

  @override
  void initState() {
    super.initState();
    _scanImage();
  }

  Future<void> _scanImage() async {
    try {
      final Directory directory = Directory(widget.bgInfo!.imageFolder);
      final List<FileSystemEntity> files = directory.listSync();
      for (final FileSystemEntity file in files) {
        if (file is File) {
          _imageList.add(file.path);
        }
      }
    } catch (e) {
      AppInfoBar.show(context, 'content');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageList.isEmpty) return const Placeholder();
    return LoopWidgetBox(children: _imageList.map((String p) => SizedBox.expand(child: AppImg.cover(url: p))).toList());
  }
}
