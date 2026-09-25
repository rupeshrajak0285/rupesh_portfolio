import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../providers/nav_provider.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/particle_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final nav = context.read<NavProvider>();
    nav.scrollController.addListener(nav.onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavProvider>();

    Widget tracked(NavSection section, Widget child) => child;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MobileMenu(),
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Positioned.fill(
            child: Scrollbar(
              controller: nav.scrollController,
              child: SingleChildScrollView(
                controller: nav.scrollController,
                child: Column(
                  children: [
                    tracked(NavSection.home, HeroSection(sectionKey: nav.keys[NavSection.home]!)),
                    tracked(NavSection.about, AboutSection(sectionKey: nav.keys[NavSection.about]!)),
                    tracked(NavSection.skills, SkillsSection(sectionKey: nav.keys[NavSection.skills]!)),
                    tracked(NavSection.experience, ExperienceSection(sectionKey: nav.keys[NavSection.experience]!)),
                    tracked(NavSection.projects, ProjectsSection(sectionKey: nav.keys[NavSection.projects]!)),
                    tracked(NavSection.education, EducationSection(sectionKey: nav.keys[NavSection.education]!)),
                    tracked(NavSection.contact, ContactSection(sectionKey: nav.keys[NavSection.contact]!)),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer()),
          ),
          const _BackToTop(),
        ],
      ),
    );
  }
}

class _BackToTop extends StatelessWidget {
  const _BackToTop();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    return Positioned(
      right: 24,
      bottom: 24,
      child: AnimatedScale(
        scale: nav.scrolled ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: Tooltip(
          message: 'Back to top',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => nav.scrollTo(NavSection.home),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: .45), blurRadius: 24)],
                ),
                child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white, size: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
