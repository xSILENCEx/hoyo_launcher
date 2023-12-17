import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_builder.dart';
import 'package:hoyo_launcher/presentation/widgets/ex_value_builder/ex_value_notifier.dart';

class BlurBox extends StatelessWidget {
  const BlurBox(this._valueNotifier, {super.key});

  final ExValue<double> _valueNotifier;

  @override
  Widget build(BuildContext context) {
    final FluentThemeData fluentTheme = FluentTheme.of(context);

    return ExValueBuilder<double>(
      valueListenable: _valueNotifier,
      builder: (_, double width, Widget? child) {
        return ClipPath(clipper: _BlurBoxClipper(width), child: child);
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ColoredBox(color: fluentTheme.scaffoldBackgroundColor.withOpacity(0.5)),
      ),
    );
  }
}

class _BlurBoxClipper extends CustomClipper<Path> {
  _BlurBoxClipper(this.width);

  final double width;

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    const double radius = 8;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, 50)
      ..lineTo(width + radius, 50)
      ..arcToPoint(
        Offset(width, 50 + radius),
        clockwise: false,
        radius: const Radius.circular(radius),
      )
      ..lineTo(width, h)
      ..lineTo(0, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_BlurBoxClipper oldClipper) => oldClipper.width != width;
}
