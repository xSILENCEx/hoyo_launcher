import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/domain/game/entities/game_info_entity.dart';
import 'package:hoyo_launcher/presentation/ui/home/home.dart';
import 'package:hoyo_launcher/presentation/ui/home/nav_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_notifier.dart';

mixin NavMixin on State<Home> {
  GameInfoEntity? selectedIem;

  final ExValue<double> navBarWithNotifier = ExValue<double>(NavBar.navBarMinWidth);

  void changeNavValue(GameInfoEntity? info) {
    selectedIem = info;
  }

  void changeNav(GameInfoEntity info) {
    if (selectedIem == info) return;
    changeNavValue(info);
    setState(() {});
  }

  void onNavHover(double value) {
    navBarWithNotifier.value = value;
  }

  @override
  void dispose() {
    navBarWithNotifier.dispose();
    super.dispose();
  }
}
