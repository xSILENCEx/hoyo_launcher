import 'package:flutter/material.dart';

const Duration _kHoverDuration = Duration(milliseconds: 300);
const Curve _curve = Curves.ease;

/// 鼠标悬停时显示的盒子
class NavHoverBox extends StatefulWidget {
  const NavHoverBox({
    super.key,
    required this.minWidth,
    required this.maxWidth,
    required this.childBuilder,
  });

  final double minWidth;
  final double maxWidth;
  final Widget Function(double value) childBuilder;

  @override
  State<NavHoverBox> createState() => _NavHoverBoxState();
}

class _NavHoverBoxState extends State<NavHoverBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onEnter(_) async {
    await _controller.animateTo(1, duration: _kHoverDuration, curve: _curve);
  }

  Future<void> _onExit(_) async {
    await _controller.animateTo(0, duration: _kHoverDuration, curve: _curve);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, Widget? child) {
        final double value = _controller.value;
        return SizedBox(
          width: value * (widget.maxWidth - widget.minWidth) + widget.minWidth,
          child: MouseRegion(
            onEnter: _onEnter,
            onExit: _onExit,
            child: widget.childBuilder(value),
          ),
        );
      },
    );
  }
}
