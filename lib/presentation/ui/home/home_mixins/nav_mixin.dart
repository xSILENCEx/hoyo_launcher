import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/ui/home/home.dart';
import 'package:hoyo_launcher/presentation/ui/home/nav_bar.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_notifier.dart';

mixin NavMixin on State<Home> {
  int navIndex = 0;

  final ExValue<double> navBarWithNotifier = ExValue<double>(NavBar.navBarMinWidth);

  void changeNavValue(int index) {
    if (index < 0) {
      navIndex = 0;
    } else {
      navIndex = index;
    }
  }

  void changeNav(int index) {
    if (navIndex == index) return;
    changeNavValue(index);
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
