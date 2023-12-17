import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/utils/l10n_tool.dart';

class GameInfoPage extends StatelessWidget {
  const GameInfoPage({super.key, required this.gameInfo});

  final GameInfoEntity gameInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(color: Colors.purple.withOpacity(0.2)),
        Padding(
          padding: const EdgeInsets.only(right: 40, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FilledButton(
                onPressed: () {},
                style: ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(horizontal: 34, vertical: 10))),
                child: Text(l10n.start_game, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
