import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/models.dart';
import '../../data/portfolio_data.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';
import '../widgets/tag_chip.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 3);
    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'education',
            title: 'Academic background',
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
                  for (var i = 0; i < PortfolioData.education.length; i++)
                    SizedBox(
                      width: width,
                      child: Reveal(
                        delay: Duration(milliseconds: 100 * i),
                        child: _EducationCard(edu: PortfolioData.education[i]),
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

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.edu});
  final Education edu;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      glow: AppColors.warning,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: edu.logo != null
                    ? Image.asset(edu.logo!, fit: BoxFit.contain)
                    : Icon(FontAwesomeIcons.graduationCap.data, color: AppColors.primary),
              ),
              const Spacer(),
              TagChip(edu.year, color: AppColors.warning, small: true),
            ],
          ),
          const SizedBox(height: 18),
          Text(edu.degree, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18)),
          const SizedBox(height: 6),
          Text(edu.institution, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(FontAwesomeIcons.award.data, size: 14, color: AppColors.success),
              const SizedBox(width: 8),
              Text(edu.score, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}
