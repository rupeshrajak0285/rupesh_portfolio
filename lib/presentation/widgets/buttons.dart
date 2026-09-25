import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(_hover ? 1.03 : 1, _hover ? 1.03 : 1, 1),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _hover ? .55 : .3),
                blurRadius: _hover ? 32 : 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.loading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              else if (widget.icon != null)
                Icon(widget.icon, size: 18, color: Colors.white),
              if (widget.icon != null || widget.loading) const SizedBox(width: 10),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutlineButton extends StatefulWidget {
  const OutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _hover ? Colors.white.withValues(alpha: .06) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hover ? AppColors.secondary : AppColors.borderStrong,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: AppColors.textPrimary),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIconButton extends StatefulWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.size = 44,
  });
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final double size;

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: widget.size,
            height: widget.size,
            transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
            decoration: BoxDecoration(
              color: _hover ? AppColors.primary : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _hover ? AppColors.primary : AppColors.border),
              boxShadow: [
                if (_hover)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: .4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            child: Icon(
              widget.icon,
              size: widget.size * .42,
              color: _hover ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
