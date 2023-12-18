import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/widgets/hover_builder.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({
    super.key,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.radius = 4.0,
    this.onTap,
    required this.child,
    this.alignment,
  });

  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Alignment? alignment;

  final Widget child;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    final Color btnColor = color ?? fluentTheme.accentColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: HoverBuilder(
        builder: (bool isHover) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            width: width,
            height: height,
            alignment: alignment,
            decoration: BoxDecoration(
              color: btnColor.lerpWith(fluentTheme.activeColor, isHover ? 0.2 : 0.0),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: fluentTheme.activeColor),
              child: IconTheme(
                data: IconThemeData(color: fluentTheme.activeColor, size: 14),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
