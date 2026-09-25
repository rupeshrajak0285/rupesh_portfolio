import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import 'gradient_text.dart';
import 'reveal.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.centered = true,
  });
  /// Rendered as a Dart comment, e.g. `// about_me`
  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    return Reveal(
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withValues(alpha: .35)),
              color: AppColors.primary.withValues(alpha: .07),
            ),
            child: Text(
              '// ${eyebrow.toLowerCase().replaceAll(' ', '_')}',
              style: GoogleFonts.jetBrainsMono(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 18),
          GradientText(
            title,
            textAlign: textAlign,
            gradient: const LinearGradient(colors: [Colors.white, AppColors.textSecondary]),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: isMobile ? 34 : 46),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(subtitle!, textAlign: textAlign, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ],
      ),
    );
  }
}
