import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum LoopAnimationType { fade, slide }

/// 自动循环播放 children 的 widget
/// 可以自定义切换动画
class LoopImageBox extends StatefulWidget {
  const LoopImageBox({
    super.key,
    required this.children,
    this.interval = const Duration(seconds: 10),
    this.animateDuration = const Duration(milliseconds: 500),
    this.curve = Curves.ease,
    this.animationType = LoopAnimationType.fade,
    this.randomSwitch = true,
  });

  final List<Widget> children;
  final Duration interval;
  final Duration animateDuration;
  final Curve curve;
  final LoopAnimationType animationType;
  final bool randomSwitch;

  @override
  State<LoopImageBox> createState() => _LoopImageBoxState();
}

class _LoopImageBoxState extends State<LoopImageBox> {
  late final Random _random = Random();

  late int _index = _random.nextInt(widget.children.length);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  void _start() {
    _cancel();
    _timer = Timer.periodic(widget.interval, (Timer timer) {
      if (!mounted) return;
      _switch();
    });
  }

  void _cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void _switch() {
    if (widget.randomSwitch) {
      _index = _random.nextInt(widget.children.length);
    } else {
      _index = (_index + 1) % widget.children.length;
    }

    setState(() {});
  }

  void _onDoubleTap() {
    _switch();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: AnimatedSwitcher(
        duration: widget.animateDuration,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: KeyedSubtree(
          key: ValueKey<int>(_index),
          child: widget.children[_index],
        ),
      ),
    );
  }

  // Widget _fadeTransitionBuilder(Widget child, Animation<double> animation) {
  //   return FadeTransition(opacity: animation, child: child);
  // }

  // Widget _slideTransitionBuilder(Widget child, Animation<double> animation) {
  //   return SlideTransition(
  //     position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(animation),
  //     child: child,
  //   );
  // }
}
