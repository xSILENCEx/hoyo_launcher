import 'package:flutter/material.dart';

class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(bool isHover) builder;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: widget.builder(_isHover),
    );
  }
}
