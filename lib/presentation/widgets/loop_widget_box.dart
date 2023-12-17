import 'dart:math';

import 'package:flutter/material.dart';

enum LoopAnimationType { fade, slide }

/// 自动循环播放 children 的 widget
/// 可以自定义切换动画
class LoopWidgetBox extends StatefulWidget {
  const LoopWidgetBox({
    super.key,
    required this.children,
    this.interval = const Duration(seconds: 10),
    this.curve = Curves.linear,
    this.animationType = LoopAnimationType.fade,
  });

  final List<Widget> children;
  final Duration interval;
  final Curve curve;
  final LoopAnimationType animationType;

  @override
  State<LoopWidgetBox> createState() => _LoopWidgetBoxState();
}

class _LoopWidgetBoxState extends State<LoopWidgetBox> {
  late int _index = Random().nextInt(widget.children.length);

  @override
  void initState() {
    super.initState();
    _loop();
  }

  Future<void> _loop() async {
    await Future<void>.delayed(widget.interval);
    if (!mounted) return;

    setState(() {
      _index = (_index + 1) % widget.children.length;
    });

    _loop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      // transitionBuilder: (Widget child, Animation<double> animation) {
      //   switch (widget.animationType) {
      //     case LoopAnimationType.fade:
      //       return _fadeTransitionBuilder(child, animation);
      //     case LoopAnimationType.slide:
      //       return _slideTransitionBuilder(child, animation);
      //   }
      // },
      child: KeyedSubtree(
        key: ValueKey<int>(_index),
        child: widget.children[_index],
      ),
    );
  }

  Widget _fadeTransitionBuilder(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }

  Widget _slideTransitionBuilder(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(animation),
      child: child,
    );
  }
}
