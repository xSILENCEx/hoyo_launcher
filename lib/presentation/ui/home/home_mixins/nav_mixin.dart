import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/ui/home/home.dart';

mixin NavMixin on State<Home> {
  int navIndex = 0;

  void changeNav(int index) {
    if (navIndex == index) return;
    setState(() => navIndex = index);
  }
}
