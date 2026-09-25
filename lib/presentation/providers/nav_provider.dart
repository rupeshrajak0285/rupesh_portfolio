import 'package:flutter/material.dart';

enum NavSection { home, about, skills, experience, projects, education, contact }

extension NavSectionLabel on NavSection {
  String get label {
    switch (this) {
      case NavSection.home:
        return 'Home';
      case NavSection.about:
        return 'About';
      case NavSection.skills:
        return 'Skills';
      case NavSection.experience:
        return 'Experience';
      case NavSection.projects:
        return 'Projects';
      case NavSection.education:
        return 'Education';
      case NavSection.contact:
        return 'Contact';
    }
  }
}

/// Holds section keys, tracks the active section and drives smooth scrolling.
class NavProvider extends ChangeNotifier {
  NavProvider() {
    for (final s in NavSection.values) {
      keys[s] = GlobalKey(debugLabel: s.name);
    }
  }

  final ScrollController scrollController = ScrollController();
  final Map<NavSection, GlobalKey> keys = {};

  NavSection _active = NavSection.home;
  NavSection get active => _active;

  bool _scrolled = false;
  bool get scrolled => _scrolled;

  double _progress = 0;
  double get progress => _progress;

  void onScroll() {
    final offset = scrollController.offset;
    final max = scrollController.position.maxScrollExtent;
    final scrolled = offset > 24;
    final progress = max == 0 ? 0.0 : (offset / max).clamp(0.0, 1.0);
    if (scrolled != _scrolled || (progress - _progress).abs() > 0.002) {
      _scrolled = scrolled;
      _progress = progress;
      notifyListeners();
    }
  }

  void setActive(NavSection section) {
    if (_active == section) return;
    _active = section;
    notifyListeners();
  }

  Future<void> scrollTo(NavSection section) async {
    final ctx = keys[section]?.currentContext;
    if (ctx == null) return;
    setActive(section);
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
