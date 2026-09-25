import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// Infinite horizontal marquee of technology chips.
class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key, required this.items, this.reverse = false, this.speed = 40});
  final List<(IconData, String)> items;
  final bool reverse;
  final double speed; // px per second

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 30))..repeat();
  final _rowKey = GlobalKey();
  double _rowWidth = 0;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final w = _rowKey.currentContext?.size?.width ?? 0;
      if (w != _rowWidth && mounted) setState(() => _rowWidth = w);
    });

    final row = Row(mainAxisSize: MainAxisSize.min, children: [for (final i in widget.items) _Chip(icon: i.$1, label: i.$2)]);

    return ShaderMask(
      shaderCallback: (r) => const LinearGradient(
        colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
        stops: [0, .12, .88, 1],
      ).createShader(r),
      blendMode: BlendMode.dstIn,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            final total = _rowWidth == 0 ? 1.0 : _rowWidth;
            final duration = total / widget.speed;
            final t = (_c.value * 30 / duration) % 1.0;
            final dx = (widget.reverse ? t : -t) * total;
            return Transform.translate(
              offset: Offset(widget.reverse ? dx - total : dx, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KeyedSubtree(key: _rowKey, child: row),
                  row,
                  row,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(label, style: GoogleFonts.jetBrainsMono(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
