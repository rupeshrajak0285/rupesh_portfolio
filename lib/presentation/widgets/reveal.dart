import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Plays a fade + slide animation the first time the child scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 40),
    this.duration = const Duration(milliseconds: 700),
  });
  final Widget child;
  final Duration delay;
  final Offset offset;
  final Duration duration;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _visible = false;
  static int _counter = 0;
  late final Key _key = ValueKey('reveal_${_counter++}');

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.08 && mounted) {
          setState(() => _visible = true);
        }
      },
      child: _visible
          ? widget.child
              .animate(delay: widget.delay)
              .fadeIn(duration: widget.duration, curve: Curves.easeOutCubic)
              .move(
                begin: widget.offset,
                end: Offset.zero,
                duration: widget.duration,
                curve: Curves.easeOutCubic,
              )
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
