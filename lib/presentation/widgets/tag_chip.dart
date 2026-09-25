import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.color = AppColors.primary, this.small = false});
  final String label;
  final Color color;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 10 : 14, vertical: small ? 5 : 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: .35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > .5 ? color : Color.lerp(color, Colors.white, .35),
          fontSize: small ? 12 : 13,
          fontWeight: FontWeight.w600,
          letterSpacing: .2,
        ),
      ),
    );
  }
}
