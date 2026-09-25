import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../providers/nav_provider.dart';
import '../widgets/buttons.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavProvider>();
    final isMobile = Responsive.isMobile(context);
    final year = DateTime.now().year;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
        color: AppColors.surface,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.horizontalPadding(context),
              vertical: 40,
            ),
            child: Column(
              children: [
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(PortfolioData.name, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4),
                        const Text(PortfolioData.role, style: TextStyle(color: AppColors.textMuted)),
                      ],
                    ),
                    if (!isMobile) const Spacer() else const SizedBox(height: 20),
                    Wrap(
                      spacing: 4,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final s in NavSection.values)
                          TextButton(
                            onPressed: () => nav.scrollTo(s),
                            style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
                            child: Text(s.label),
                          ),
                      ],
                    ),
                    if (!isMobile) const SizedBox(width: 24) else const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      children: [
                        for (final s in PortfolioData.socials)
                          SocialIconButton(icon: s.icon, tooltip: s.label, size: 40, onTap: () => UrlUtils.open(s.url)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    Text('© $year ${PortfolioData.name}. Built with', style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                    Icon(FontAwesomeIcons.flutter.data, size: 13, color: AppColors.secondary),
                    const Text('Flutter Web &', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                    Icon(FontAwesomeIcons.fire.data, size: 13, color: AppColors.warning),
                    const Text('Firebase', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
