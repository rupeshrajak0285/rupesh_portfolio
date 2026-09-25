import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/models/models.dart';
import '../../data/portfolio_data.dart';
import '../../services/firebase_service.dart';
import '../widgets/buttons.dart';
import '../widgets/device_frame.dart';
import '../widgets/glow_blob.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';
import '../widgets/tag_chip.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _filters = ['All', 'On Stores', 'Odoo', 'Firebase', 'Web', 'Open Source'];
  String _filter = 'All';

  List<Project> get _visible =>
      _filter == 'All' ? PortfolioData.projects : PortfolioData.projects.where((p) => p.tags.contains(_filter)).toList();

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(context, mobile: 1, tablet: 2, desktop: 3);
    final total = PortfolioData.projects.length;

    return SectionContainer(
      sectionKey: widget.sectionKey,
      background: Stack(
        children: [
          Positioned(top: 200, left: -220, child: GlowBlob(color: AppColors.navy, size: 620, opacity: .35)),
          Positioned(bottom: 100, right: -200, child: GlowBlob(color: AppColors.accent, size: 520, opacity: .12)),
        ],
      ),
      child: Column(
        children: [
          SectionHeader(
            eyebrow: 'projects',
            title: '$total apps, one codebase philosophy',
            subtitle: 'Production apps live on the Play Store and App Store, Odoo-integrated business apps, and open-source work on pub.dev.',
          ),
          const SizedBox(height: 32),
          Reveal(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final f in _filters)
                  _FilterChip(
                    label: f,
                    count: f == 'All' ? total : PortfolioData.projects.where((p) => p.tags.contains(f)).length,
                    selected: _filter == f,
                    onTap: () => setState(() => _filter = f),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 22.0;
              final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
              final visible = _visible;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: Wrap(
                  key: ValueKey(_filter),
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < visible.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 80 * (i % columns)),
                          child: ProjectCard(project: visible[i]),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.count, required this.selected, required this.onTap});
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            gradient: selected ? AppColors.primaryGradient : null,
            color: selected ? null : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: selected ? Colors.transparent : AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(color: selected ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 13.5)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: selected ? .2 : .06), borderRadius: BorderRadius.circular(999)),
                child: Text('$count', style: GoogleFonts.jetBrainsMono(fontSize: 11, color: selected ? Colors.white : AppColors.textMuted)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;
    return HoverCard(
      glow: p.accent,
      padding: EdgeInsets.zero,
      onTap: () => _showDetails(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectVisual(project: p),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (p.icon != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.asset(p.icon!, width: 34, height: 34, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(child: Text(p.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    for (final pl in p.platforms)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(_platformIcon(pl), size: 14, color: AppColors.textMuted),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TagChip(p.category, color: p.accent, small: true),
                    if (p.inProgress) ...[
                      const SizedBox(width: 6),
                      const TagChip('In progress', color: AppColors.warning, small: true),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                Text(p.tagline, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final t in p.tech.take(4)) TagChip(t, small: true, color: AppColors.textSecondary)],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (p.playStoreUrl != null) _StoreBadge(asset: 'assets/images/play_store.png', label: 'Play Store', url: p.playStoreUrl!),
                    if (p.appStoreUrl != null) _StoreBadge(asset: 'assets/images/app_store.png', label: 'App Store', url: p.appStoreUrl!),
                    if (p.webUrl != null) _StoreBadge(icon: FontAwesomeIcons.globe.data, label: 'Visit site', url: p.webUrl!),
                    if (p.pubDevUrl != null) _StoreBadge(icon: FontAwesomeIcons.dartLang.data, label: 'pub.dev', url: p.pubDevUrl!),
                    const Spacer(),
                    Text(p.hasScreens ? '${p.screenshots.length} screens' : 'Details',
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(width: 6),
                    Icon(FontAwesomeIcons.arrowRight.data, size: 12, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static IconData _platformIcon(ProjectPlatform p) {
    switch (p) {
      case ProjectPlatform.android:
        return FontAwesomeIcons.android.data;
      case ProjectPlatform.ios:
        return FontAwesomeIcons.apple.data;
      case ProjectPlatform.web:
        return FontAwesomeIcons.globe.data;
      case ProjectPlatform.package:
        return FontAwesomeIcons.boxOpen.data;
    }
  }

  void _showDetails(BuildContext context) {
    FirebaseService.instance.logEvent('project_open', {'project': project.title});
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: .75),
      builder: (_) => ProjectDetailDialog(project: project),
    );
  }
}

/// Card header: fanned phone screenshots, a web image, or an icon tile.
class _ProjectVisual extends StatelessWidget {
  const _ProjectVisual({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [p.accent.withValues(alpha: .28), AppColors.surfaceElevated.withValues(alpha: .6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: p.hasScreens
              ? _ScreenFan(project: p)
              : p.image != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(p.image!, fit: BoxFit.cover, alignment: Alignment.topCenter),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (p.icon != null)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(color: p.accent.withValues(alpha: .45), blurRadius: 40)],
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(p.icon!, width: 84, height: 84, fit: BoxFit.cover)),
                            )
                          else
                            Icon(
                              p.platforms.contains(ProjectPlatform.package) ? FontAwesomeIcons.boxOpen.data : FontAwesomeIcons.mobileScreenButton.data,
                              size: 42,
                              color: p.accent,
                            ),
                          const SizedBox(height: 14),
                          Text(p.title, style: GoogleFonts.jetBrainsMono(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class _ScreenFan extends StatelessWidget {
  const _ScreenFan({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final shots = project.screenshots.take(3).toList();
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth * .30;
        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            if (shots.length > 1)
              Positioned(
                left: c.maxWidth * .10,
                top: c.maxHeight * .20,
                child: Transform.rotate(angle: -.10, child: Opacity(opacity: .85, child: DeviceFrame(image: shots[1], width: w * .9, glow: project.accent))),
              ),
            if (shots.length > 2)
              Positioned(
                right: c.maxWidth * .10,
                top: c.maxHeight * .20,
                child: Transform.rotate(angle: .10, child: Opacity(opacity: .85, child: DeviceFrame(image: shots[2], width: w * .9, glow: project.accent))),
              ),
            Positioned(
              left: 0,
              right: 0,
              top: c.maxHeight * .10,
              child: Center(child: DeviceFrame(image: shots[0], width: w, glow: project.accent)),
            ),
          ],
        );
      },
    );
  }
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({this.asset, this.icon, required this.label, required this.url});
  final String? asset;
  final IconData? icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Tooltip(
        message: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => UrlUtils.open(url),
            child: Container(
              width: 34,
              height: 34,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: AppColors.surfaceElevated, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
              child: asset != null ? Image.asset(asset!, fit: BoxFit.contain) : Icon(icon, size: 15, color: AppColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectDetailDialog extends StatelessWidget {
  const ProjectDetailDialog({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;
    final isMobile = Responsive.isMobile(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? 12 : 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: p.accent.withValues(alpha: .4)),
            boxShadow: [BoxShadow(color: p.accent.withValues(alpha: .25), blurRadius: 60)],
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Container(
                  padding: EdgeInsets.fromLTRB(isMobile ? 20 : 30, 24, 16, 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [p.accent.withValues(alpha: .22), Colors.transparent]),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (p.icon != null) ...[
                        ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(p.icon!, width: 56, height: 56, fit: BoxFit.cover)),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: isMobile ? 22 : 26)),
                            const SizedBox(height: 4),
                            Text(p.tagline, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                TagChip(p.category, color: p.accent, small: true),
                                if (p.inProgress) const TagChip('In progress', color: AppColors.warning, small: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                if (p.hasScreens) _Gallery(project: p, height: isMobile ? 300 : 380),
                if (!p.hasScreens && p.image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(p.image!, fit: BoxFit.cover)),
                  ),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 20 : 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.description, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 22),
                      Text('// key_features', style: GoogleFonts.jetBrainsMono(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      for (final f in p.features)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: const EdgeInsets.only(top: 3), child: Icon(FontAwesomeIcons.circleCheck.data, size: 14, color: p.accent)),
                              const SizedBox(width: 10),
                              Expanded(child: Text(f, style: Theme.of(context).textTheme.bodyMedium)),
                            ],
                          ),
                        ),
                      const SizedBox(height: 18),
                      Wrap(spacing: 8, runSpacing: 8, children: [for (final t in p.tech) TagChip(t, color: p.accent)]),
                      if (p.hasStoreLinks || p.githubUrl != null) ...[
                        const SizedBox(height: 26),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            if (p.playStoreUrl != null) PrimaryButton(label: 'Google Play', icon: FontAwesomeIcons.googlePlay.data, onPressed: () => UrlUtils.open(p.playStoreUrl!)),
                            if (p.appStoreUrl != null) OutlineButton(label: 'App Store', icon: FontAwesomeIcons.apple.data, onPressed: () => UrlUtils.open(p.appStoreUrl!)),
                            if (p.webUrl != null) PrimaryButton(label: 'Visit Website', icon: FontAwesomeIcons.globe.data, onPressed: () => UrlUtils.open(p.webUrl!)),
                            if (p.pubDevUrl != null) PrimaryButton(label: 'View on pub.dev', icon: FontAwesomeIcons.dartLang.data, onPressed: () => UrlUtils.open(p.pubDevUrl!)),
                            if (p.githubUrl != null) OutlineButton(label: 'GitHub', icon: FontAwesomeIcons.github.data, onPressed: () => UrlUtils.open(p.githubUrl!)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal strip of framed screenshots; tap to open the full-screen viewer.
class _Gallery extends StatelessWidget {
  const _Gallery({required this.project, required this.height});
  final Project project;
  final double height;

  @override
  Widget build(BuildContext context) {
    final w = height / 2.1;
    return SizedBox(
      height: height + 24,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad}),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          itemCount: project.screenshots.length,
          separatorBuilder: (_, __) => const SizedBox(width: 18),
          itemBuilder: (context, i) => MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _openViewer(context, i),
              child: DeviceFrame(image: project.screenshots[i], width: w, glow: project.accent)
                  .animate(delay: Duration(milliseconds: 80 * i))
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: .1),
            ),
          ),
        ),
      ),
    );
  }

  void _openViewer(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: .92),
      builder: (_) => _ScreenshotViewer(images: project.screenshots, initial: index, accent: project.accent),
    );
  }
}

class _ScreenshotViewer extends StatefulWidget {
  const _ScreenshotViewer({required this.images, required this.initial, required this.accent});
  final List<String> images;
  final int initial;
  final Color accent;

  @override
  State<_ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<_ScreenshotViewer> {
  late final PageController _controller = PageController(initialPage: widget.initial);
  late int _index = widget.initial;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, widget.images.length - 1);
    _controller.animateToPage(next, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final frameW = (size.height * .78) / 2.1;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => Center(
              child: InteractiveViewer(
                maxScale: 3,
                child: DeviceFrame(image: widget.images[i], width: frameW.clamp(180, 360), glow: widget.accent),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: Colors.white12),
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
          ),
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(child: _NavBtn(icon: Icons.chevron_left_rounded, onTap: _index > 0 ? () => _go(-1) : null)),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(child: _NavBtn(icon: Icons.chevron_right_rounded, onTap: _index < widget.images.length - 1 ? () => _go(1) : null)),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(999)),
                child: Text('${_index + 1} / ${widget.images.length}', style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  const _NavBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(backgroundColor: Colors.white12, disabledBackgroundColor: Colors.white.withValues(alpha: .04)),
      onPressed: onTap,
      icon: Icon(icon, color: onTap == null ? Colors.white24 : Colors.white, size: 30),
    );
  }
}
