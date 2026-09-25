import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/models.dart';
import '../../data/portfolio_data.dart';
import '../widgets/glow_blob.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';
import '../widgets/tag_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 3);

    return SectionContainer(
      sectionKey: sectionKey,
      background: Stack(
        children: [
          Positioned(top: 100, right: -200, child: GlowBlob(color: AppColors.accent, size: 520, opacity: .14)),
        ],
      ),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'skills',
            title: 'A full-stack mobile toolkit',
            subtitle: 'Technologies I use daily to build scalable, high-performance applications.',
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < PortfolioData.skillGroups.length; i++)
                    SizedBox(
                      width: width,
                      child: Reveal(
                        delay: Duration(milliseconds: 80 * (i % columns)),
                        child: _SkillCard(group: PortfolioData.skillGroups[i]),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.group});
  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      glow: group.color,
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: group.color.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: group.color.withValues(alpha: .4)),
                ),
                child: Icon(group.icon, size: 18, color: group.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final s in group.skills) TagChip(s, color: group.color, small: true)],
          ),
        ],
      ),
    );
  }
}
