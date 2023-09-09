import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  const FadeInWidget({
    super.key,
    this.index = 0,
    this.duration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 300),
    required this.child,
  });

  final int index;
  final Duration delay;
  final Duration duration;
  final Widget child;

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    final index = max(widget.index, 0);
    final delay = widget.delay.let((v) => index == 0 ? v : v * (0.5 + index));
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(delay).then((_) {
        if (!mounted) return;
        setState(() => _visible = true);
      }),
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        child: widget.child,
      );
}
