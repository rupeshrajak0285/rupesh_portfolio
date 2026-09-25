import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/models/models.dart';
import '../../data/portfolio_data.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';
import '../widgets/tag_chip.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'experience',
            title: 'Professional journey',
            subtitle: 'Three and a half years of shipping production apps across CRM, healthcare, fintech and EdTech.',
          ),
          const SizedBox(height: 56),
          for (var i = 0; i < PortfolioData.experiences.length; i++)
            _TimelineItem(
              experience: PortfolioData.experiences[i],
              isLast: i == PortfolioData.experiences.length - 1,
              compact: isMobile,
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  const _TimelineItem({required this.experience, required this.isLast, required this.compact});
  final Experience experience;
  final bool isLast;
  final bool compact;

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.experience;
    final visible = _expanded ? e.highlights : e.highlights.take(3).toList();

    final card = Reveal(
      offset: const Offset(40, 0),
      child: HoverCard(
        glow: e.isCurrent ? AppColors.secondary : AppColors.primary,
        padding: EdgeInsets.all(widget.compact ? 20 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CompanyLogo(logo: e.logo, company: e.company),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(e.role, style: Theme.of(context).textTheme.titleLarge),
                          ),
                          if (e.isCurrent) ...[
                            const SizedBox(width: 10),
                            const TagChip('Current', color: AppColors.success, small: true),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      MouseRegion(
                        cursor: e.companyUrl != null ? SystemMouseCursors.click : MouseCursor.defer,
                        child: GestureDetector(
                          onTap: e.companyUrl != null ? () => UrlUtils.open(e.companyUrl!) : null,
                          child: Text(
                            e.company,
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 14,
                        children: [
                          _Meta(icon: FontAwesomeIcons.calendar.data, text: e.period),
                          _Meta(icon: FontAwesomeIcons.locationDot.data, text: e.location),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  for (final h in visible)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 9),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(h, style: Theme.of(context).textTheme.bodyMedium)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (e.highlights.length > 3)
              TextButton.icon(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(foregroundColor: AppColors.secondary, padding: EdgeInsets.zero),
                icon: AnimatedRotation(
                  turns: _expanded ? .5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(Icons.expand_more_rounded, size: 20),
                ),
                label: Text(_expanded ? 'Show less' : 'Show ${e.highlights.length - 3} more'),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final t in e.tech) TagChip(t, small: true, color: AppColors.textSecondary)],
            ),
          ],
        ),
      ),
    );

    if (widget.compact) {
      return Padding(padding: const EdgeInsets.only(bottom: 24), child: card);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withValues(alpha: .6), blurRadius: 14),
                    ],
                  ),
                ).animate(onPlay: (c) => e.isCurrent ? c.repeat(reverse: true) : null).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.25, 1.25),
                      duration: 1.seconds,
                    ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.primary.withValues(alpha: .6), AppColors.primary.withValues(alpha: .05)],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(bottom: 32), child: card),
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.logo, required this.company});
  final String? logo;
  final String company;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(6),
      child: logo != null
          ? Image.asset(logo!, fit: BoxFit.contain)
          : Center(
              child: Text(
                company.substring(0, 1),
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 22),
              ),
            ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
      ],
    );
  }
}
