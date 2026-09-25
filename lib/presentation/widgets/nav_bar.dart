import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../providers/nav_provider.dart';
import 'buttons.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onMenuTap});
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    final isDesktop = Responsive.isDesktop(context);
    final scrolled = nav.scrolled;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: scrolled ? 16 : 0, sigmaY: scrolled ? 16 : 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: scrolled ? 68 : 84,
          decoration: BoxDecoration(
            color: scrolled ? AppColors.background.withValues(alpha: .72) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: scrolled ? AppColors.border : Colors.transparent,
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.horizontalPadding(context),
                      ),
                      child: Row(
                        children: [
                          _Logo(onTap: () => nav.scrollTo(NavSection.home)),
                          const Spacer(),
                          if (isDesktop) ...[
                            for (final s in NavSection.values)
                              _NavItem(
                                label: s.label,
                                active: nav.active == s,
                                onTap: () => nav.scrollTo(s),
                              ),
                            const SizedBox(width: 16),
                            OutlineButton(
                              label: 'Resume',
                              icon: FontAwesomeIcons.fileArrowDown.data,
                              onPressed: () => UrlUtils.open(PortfolioData.resumeAsset),
                            ),
                            const SizedBox(width: 12),
                            PrimaryButton(
                              label: "Let's Talk",
                              onPressed: () => nav.scrollTo(NavSection.contact),
                            ),
                          ] else
                            IconButton(
                              onPressed: onMenuTap,
                              icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 28),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Scroll progress indicator
              SizedBox(
                height: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: nav.progress,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(gradient: AppColors.heroGradient),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: .4),
                    blurRadius: 16,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'R',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: '<', style: TextStyle(color: AppColors.primary)),
                const TextSpan(text: 'Rupesh'),
                const TextSpan(text: ' />', style: TextStyle(color: AppColors.primary)),
              ]),
              style: GoogleFonts.jetBrainsMono(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: highlighted ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 2,
                width: widget.active ? 18 : (_hover ? 10 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full-screen drawer used on tablet / mobile.
class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavProvider>();
    return Drawer(
      backgroundColor: AppColors.surface,
      width: 300,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 12, 8),
              child: Row(
                children: [
                  Text('Menu', style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 12),
            for (final s in NavSection.values)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 28),
                title: Text(
                  s.label,
                  style: TextStyle(
                    color: nav.active == s ? AppColors.secondary : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 250), () => nav.scrollTo(s));
                },
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButton(
                    label: 'Download Resume',
                    icon: FontAwesomeIcons.fileArrowDown.data,
                    onPressed: () => UrlUtils.open(PortfolioData.resumeAsset),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final s in PortfolioData.socials)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: SocialIconButton(
                            icon: s.icon,
                            tooltip: s.label,
                            size: 40,
                            onTap: () => UrlUtils.open(s.url),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
