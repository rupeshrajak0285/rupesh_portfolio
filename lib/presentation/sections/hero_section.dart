import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../providers/nav_provider.dart';
import '../widgets/buttons.dart';
import '../widgets/code_window.dart';
import '../widgets/glow_blob.dart';
import '../widgets/gradient_text.dart';
import '../widgets/phone_mockup.dart';
import '../widgets/section_container.dart';
import '../widgets/tech_marquee.dart';

const _heroCode = '''class RupeshRajak extends SeniorFlutterDeveloper {
  @override
  final experience = Duration(days: 365 * 3.5);

  @override
  List<Platform> get targets => [
    Platform.android, Platform.ios, Platform.web,
  ];

  @override
  Future<App> build(Idea idea) async {
    final arch = CleanArchitecture(state: Bloc());
    final native = PlatformChannels(
      voip: TwilioVoice(callKit: true, pushKit: true),
      devices: BleHealthDevices(),
    );
    final app = await ship(idea, arch, native);
    return app..release(PlayStore(), AppStore()); // 🚀
  }
}''';

const _heroCodeMobile = '''class RupeshRajak extends FlutterDev {
  final experience = 3.5.years;
  final targets = [android, ios, web];

  @override
  Future<App> build(Idea idea) async {
    final app = await ship(
      idea, CleanArchitecture(), Native(),
    );
    return app..release(); // 🚀
  }
}''';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.sectionKey});
  final Key sectionKey;

  static final List<(IconData, String)> _marqueeA = [
    (FontAwesomeIcons.flutter.data, 'Flutter'),
    (FontAwesomeIcons.dartLang.data, 'Dart'),
    (FontAwesomeIcons.fire.data, 'Firebase'),
    (Icons.layers_rounded, 'BLoC'),
    (Icons.account_tree_rounded, 'Provider'),
    (Icons.bolt_rounded, 'GetX'),
    (Icons.water_drop_rounded, 'Riverpod'),
    (FontAwesomeIcons.android.data, 'Android'),
    (FontAwesomeIcons.apple.data, 'iOS'),
    (FontAwesomeIcons.globe.data, 'Flutter Web'),
    (Icons.phone_in_talk_rounded, 'Twilio Voice'),
    (Icons.call_rounded, 'CallKit'),
    (Icons.bluetooth_rounded, 'BLE / IoT'),
    (Icons.hub_rounded, 'Odoo JSON-RPC'),
    (Icons.http_rounded, 'REST · Dio'),
    (Icons.sync_alt_rounded, 'WebSocket'),
    (Icons.architecture_rounded, 'Clean Architecture'),
    (Icons.rocket_launch_rounded, 'Shorebird'),
    (FontAwesomeIcons.googlePlay.data, 'Play Store'),
    (FontAwesomeIcons.appStoreIos.data, 'App Store'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        SectionContainer(
          sectionKey: sectionKey,
          verticalPadding: isMobile ? 110 : 150,
          background: Stack(
            children: [
              Positioned(top: -160, left: -200, child: GlowBlob(color: AppColors.navy, size: 720, opacity: .45)),
              Positioned(bottom: -220, right: -160, child: GlowBlob(color: AppColors.accent, size: 600, opacity: .16)),
              const Positioned.fill(child: _GridOverlay()),
            ],
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(flex: 10, child: _HeroText()),
                    SizedBox(width: 48),
                    Expanded(flex: 11, child: _HeroVisual()),
                  ],
                )
              : Column(children: const [_HeroText(), SizedBox(height: 56), _HeroVisual()]),
        ),
        // tech marquee strip
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              SizedBox(height: 60, child: TechMarquee(items: _marqueeA)),
              const SizedBox(height: 12),
              SizedBox(height: 60, child: TechMarquee(items: _marqueeA.reversed.toList(), reverse: true, speed: 30)),
            ],
          ),
        ).animate(delay: 900.ms).fadeIn(duration: 800.ms),
      ],
    );
  }
}

/// Subtle blueprint grid behind the hero.
class _GridOverlay extends StatelessWidget {
  const _GridOverlay();
  @override
  Widget build(BuildContext context) => IgnorePointer(child: CustomPaint(painter: _GridPainter()));
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withValues(alpha: .025)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 48) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 48) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final nav = context.read<NavProvider>();
    final display = Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: isMobile ? 44 : (isDesktop ? 68 : 58));
    final align = isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlign = isDesktop ? TextAlign.left : TextAlign.center;
    final mono = GoogleFonts.jetBrainsMono(color: AppColors.accent, fontSize: 15, fontWeight: FontWeight.w500);

    return Column(
      crossAxisAlignment: align,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _AvailabilityPill().animate().fadeIn(duration: 600.ms).slideY(begin: .3),
        const SizedBox(height: 28),
        Text('// hello world, I am', style: mono, textAlign: textAlign)
            .animate(delay: 100.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: .3),
        const SizedBox(height: 8),
        GradientText(PortfolioData.name, style: display, textAlign: textAlign)
            .animate(delay: 200.ms)
            .fadeIn(duration: 700.ms)
            .slideY(begin: .3, curve: Curves.easeOutCubic),
        const SizedBox(height: 10),
        SizedBox(
          height: isMobile ? 40 : 52,
          child: Align(
            alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
            child: DefaultTextStyle(
              style: GoogleFonts.jetBrainsMono(fontSize: isMobile ? 18 : 26, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1500),
                animatedTexts: [
                  for (final t in PortfolioData.heroTitles)
                    TypewriterAnimatedText(t, speed: const Duration(milliseconds: 55), cursor: '_', textAlign: textAlign),
                ],
              ),
            ),
          ),
        ).animate(delay: 350.ms).fadeIn(duration: 600.ms),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(PortfolioData.summary, textAlign: textAlign, style: Theme.of(context).textTheme.bodyLarge),
        ).animate(delay: 450.ms).fadeIn(duration: 700.ms).slideY(begin: .2),
        const SizedBox(height: 36),
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: [
            PrimaryButton(label: 'View Projects', icon: FontAwesomeIcons.arrowRight.data, onPressed: () => nav.scrollTo(NavSection.projects)),
            OutlineButton(label: 'Download Resume', icon: FontAwesomeIcons.fileArrowDown.data, onPressed: () => UrlUtils.open(PortfolioData.resumeAsset)),
          ],
        ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: .3),
        const SizedBox(height: 36),
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final s in PortfolioData.socials) SocialIconButton(icon: s.icon, tooltip: s.label, onTap: () => UrlUtils.open(s.url)),
          ],
        ).animate(delay: 750.ms).fadeIn(duration: 600.ms),
      ],
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.success.withValues(alpha: .35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle))
              .animate(onPlay: (c) => c.repeat())
              .scale(begin: const Offset(1, 1), end: const Offset(1.6, 1.6), duration: 900.ms)
              .then()
              .scale(begin: const Offset(1.6, 1.6), end: const Offset(1, 1), duration: 900.ms),
          const SizedBox(width: 10),
          const Text('Open to Senior Flutter opportunities', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}

/// Code editor + live phone preview with pointer parallax.
class _HeroVisual extends StatefulWidget {
  const _HeroVisual();
  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual> {
  Offset _tilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final phoneW = isMobile ? 150.0 : 190.0;

    return MouseRegion(
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final l = box.globalToLocal(e.position);
        setState(() => _tilt = Offset((l.dx / box.size.width - .5) * 2, (l.dy / box.size.height - .5) * 2));
      },
      onExit: (_) => setState(() => _tilt = Offset.zero),
      child: isMobile
          ? Column(
              children: [
                CodeWindow(code: _heroCodeMobile, fontSize: 11.5)
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: .15, curve: Curves.easeOutCubic),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: _Badge(icon: Icons.check_circle_rounded, label: 'Build succeeded', color: AppColors.success),
                    ),
                    const SizedBox(width: 16),
                    PhoneMockup(width: phoneW)
                        .animate(delay: 500.ms)
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: .2, curve: Curves.easeOutCubic),
                  ],
                ),
              ],
            )
          : LayoutBuilder(
        builder: (context, c) {
          final codeWidth = isMobile ? c.maxWidth : (c.maxWidth - (isDesktop ? 60 : 40)).clamp(280.0, 640.0);
          return SizedBox(
            height: isMobile ? 560 : 520,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .0012)
                      ..rotateY(_tilt.dx * .10)
                      ..rotateX(-_tilt.dy * .10),
                    transformAlignment: Alignment.center,
                    child: CodeWindow(code: _heroCode, width: codeWidth, fontSize: isMobile ? 10.5 : 12.5),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: .15, curve: Curves.easeOutCubic),
                ),
                Positioned(
                  right: isMobile ? -6 : 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(_tilt.dx * -14, _tilt.dy * -14, 0),
                    child: PhoneMockup(width: phoneW),
                  )
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: .2, curve: Curves.easeOutCubic)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: -10, duration: 2600.ms, curve: Curves.easeInOut),
                ),
                Positioned(
                  left: isMobile ? -4 : 20,
                  bottom: isMobile ? 120 : 40,
                  child: const _Badge(icon: Icons.check_circle_rounded, label: 'Build succeeded · 0 issues', color: AppColors.success)
                      .animate(delay: 2600.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: .4, curve: Curves.easeOutBack),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .5)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: .25), blurRadius: 24)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.jetBrainsMono(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
