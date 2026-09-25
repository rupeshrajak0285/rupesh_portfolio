import 'package:flutter/material.dart';

/// Soft radial glow used to add depth behind sections.
class GlowBlob extends StatelessWidget {
  const GlowBlob({super.key, required this.color, this.size = 480, this.opacity = .25});
  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: opacity), color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
