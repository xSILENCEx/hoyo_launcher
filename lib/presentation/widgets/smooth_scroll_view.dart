import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmoothScrollView extends StatefulWidget {
  const SmoothScrollView({super.key, required this.child});

  final Widget child;

  @override
  State<SmoothScrollView> createState() => _SmoothScrollViewState();
}

class _SmoothScrollViewState extends State<SmoothScrollView> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onMouseScroll(PointerSignalEvent event) async {
    if (event is PointerScrollEvent) {
      final double dy = event.scrollDelta.dy;
      final double p = _controller.position.pixels;

      await _controller.animateTo(
        p + dy,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onMouseScroll,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          child: widget.child,
        ),
      ),
    );
  }
}
