import 'package:flutter/material.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_bg/single_image_bg.dart';
import 'package:hoyo_launcher/presentation/widgets/app_image.dart';

class GameSingleImageBg extends StatelessWidget {
  const GameSingleImageBg({super.key, required this.bgInfo});

  final SingleImageBg? bgInfo;

  @override
  Widget build(BuildContext context) {
    return AppImg.cover(url: bgInfo?.imageUrl);
  }
}
