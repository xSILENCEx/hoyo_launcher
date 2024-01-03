import 'dart:async';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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

class _LoopImageBoxState extends State<LoopImageBox> with WindowListener {
  final List<int> _randomList = <int>[];

  late int _index;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _start();
  }

  @override
  void dispose() {
    _cancel();
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoopImageBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.children.length != widget.children.length) {
      _initRandomList();
      if (_index >= widget.children.length) {
        _index = 0;
      }
      setState(() {});
    }
  }

  @override
  void onWindowEvent(String eventName) {
    super.onWindowEvent(eventName);

    if (eventName == 'minimize') {
      _cancel();
    } else if (eventName == 'restore') {
      _start();
    }
  }

  void _initRandomList() {
    _randomList.clear();
    _randomList.addAll(List<int>.generate(widget.children.length, (int index) => index));
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
      if (_randomList.isEmpty) {
        _initRandomList();
      }
      _randomList.shuffle();
      _index = _randomList.removeAt(0);
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
