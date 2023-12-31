import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmoothScrollView extends StatefulWidget {
  factory SmoothScrollView({Key? key, required Widget child}) {
    return SmoothScrollView._(
      key: key,
      builder: (BuildContext context, ScrollController controller) =>
          _SmoothScrollViewState._scrollView(controller, child),
    );
  }

  factory SmoothScrollView.provider({
    Key? key,
    required Widget Function(BuildContext context, ScrollController controller) builder,
  }) {
    return SmoothScrollView._(
      key: key,
      builder: builder,
    );
  }

  const SmoothScrollView._({super.key, required this.builder});

  final Widget Function(BuildContext context, ScrollController controller) builder;

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

      // final double target = p + dy;

      // if (target < _controller.position.minScrollExtent) return;
      // if (target > _controller.position.maxScrollExtent) return;

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
        child: widget.builder(context, _controller),
      ),
    );
  }

  static Widget _scrollView(ScrollController _controller, Widget child) {
    return SingleChildScrollView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      child: child,
    );
  }
}
