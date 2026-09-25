import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/theme/app_colors.dart';
import 'gradient_text.dart';

/// Counts from zero to [value] once it scrolls into view.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.suffix,
    required this.label,
  });
  final double value;
  final String suffix;
  final String label;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );
  late final Animation<double> _anim =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo);
  bool _started = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('counter_${widget.label}'),
      onVisibilityChanged: (info) {
        if (!_started && info.visibleFraction > .3) {
          _started = true;
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final raw = _anim.value * widget.value;
          final v = widget.value % 1 == 0 ? raw.round().toString() : raw.toStringAsFixed(1);
          return Column(
            children: [
              GradientText(
                '$v${widget.suffix}',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 40),
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
          );
        },
      ),
    );
  }
}
