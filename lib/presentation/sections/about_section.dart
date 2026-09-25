import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../widgets/animated_counter.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';
import '../widgets/terminal_card.dart';

/// Bento-grid "about" section.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    final photo = Reveal(child: _PhotoTile(height: isDesktop ? 320 : 300));
    final bio = Reveal(delay: const Duration(milliseconds: 80), child: _BioTile());
    final stats = Reveal(delay: const Duration(milliseconds: 160), child: _StatsTile(isMobile: isMobile));
    final terminal = Reveal(delay: const Duration(milliseconds: 240), child: const TerminalCard());
    final highlights = Reveal(delay: const Duration(milliseconds: 320), child: const _HighlightsTile());

    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'about me',
            title: 'Engineering apps that ship, scale and survive production',
            subtitle: 'From architecture and native integration to release engineering on both stores.',
          ),
          const SizedBox(height: 56),
          if (isDesktop) ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: photo),
                  const SizedBox(width: 20),
                  Expanded(flex: 8, child: bio),
                ],
              ),
            ),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: stats),
                  const SizedBox(width: 20),
                  Expanded(flex: 5, child: terminal),
                  const SizedBox(width: 20),
                  Expanded(flex: 4, child: highlights),
                ],
              ),
            ),
          ] else ...[
            photo,
            const SizedBox(height: 20),
            bio,
            const SizedBox(height: 20),
            stats,
            const SizedBox(height: 20),
            terminal,
            const SizedBox(height: 20),
            highlights,
          ],
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderStrong),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: .18), blurRadius: 40, offset: const Offset(0, 16))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/profile.png', fit: BoxFit.cover, alignment: Alignment.topCenter),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xDD080C16)],
                stops: [.45, 1],
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(PortfolioData.name, style: Theme.of(context).textTheme.titleLarge),
                Text(PortfolioData.role, style: GoogleFonts.jetBrainsMono(color: AppColors.primary, fontSize: 12.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BioTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Who I am', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(PortfolioData.aboutLong, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.5)),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoRow(icon: FontAwesomeIcons.locationDot.data, text: PortfolioData.location),
              _InfoRow(icon: FontAwesomeIcons.envelope.data, text: PortfolioData.email),
              _InfoRow(icon: FontAwesomeIcons.phone.data, text: PortfolioData.phone),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsTile extends StatelessWidget {
  const _StatsTile({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      glow: AppColors.accent,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: isMobile ? 1.4 : 1.25,
        children: [for (final s in PortfolioData.stats) AnimatedCounter(value: s.value, suffix: s.suffix, label: s.label)],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primary),
          const SizedBox(width: 9),
          Text(text, style: GoogleFonts.jetBrainsMono(fontSize: 12.5, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _HighlightsTile extends StatelessWidget {
  const _HighlightsTile();

  static final _items = [
    (FontAwesomeIcons.phoneVolume.data, 'Native VoIP', 'Twilio, CallKit & PushKit'),
    (FontAwesomeIcons.heartPulse.data, 'IoT Health Devices', 'BLE streaming in real time'),
    (FontAwesomeIcons.cubes.data, 'Odoo ERP', 'JSON-RPC / XML-RPC layers'),
    (FontAwesomeIcons.boxOpen.data, 'Open Source', 'json_form_engine on pub.dev'),
  ];

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      glow: AppColors.pink,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('What sets me apart', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19)),
          const SizedBox(height: 16),
          for (final (icon, title, sub) in _items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(10)),
                    child: Icon(icon, size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5)),
                        Text(sub, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
