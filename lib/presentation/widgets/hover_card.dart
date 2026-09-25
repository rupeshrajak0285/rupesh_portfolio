import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Glassmorphic card that lifts, brightens its border and glows on hover.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(28),
    this.glow = AppColors.primary,
    this.borderRadius = 24,
    this.lift = 6,
    this.onTap,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color glow;
  final double borderRadius;
  final double lift;
  final VoidCallback? onTap;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hover ? -widget.lift : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _hover ? widget.glow.withValues(alpha: .6) : AppColors.border,
            ),
            boxShadow: [
              if (_hover)
                BoxShadow(
                  color: widget.glow.withValues(alpha: .22),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
