import 'package:flutter/material.dart';

class SocialLink {
  const SocialLink({required this.label, required this.url, required this.icon});
  final String label;
  final String url;
  final IconData icon;
}

class SkillGroup {
  const SkillGroup({
    required this.title,
    required this.icon,
    required this.skills,
    required this.color,
  });
  final String title;
  final IconData icon;
  final List<String> skills;
  final Color color;
}

class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.highlights,
    required this.tech,
    this.logo,
    this.companyUrl,
    this.isCurrent = false,
  });
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> highlights;
  final List<String> tech;
  final String? logo;
  final String? companyUrl;
  final bool isCurrent;
}

enum ProjectPlatform { android, ios, web, package }

class Project {
  const Project({
    required this.title,
    required this.category,
    required this.tagline,
    required this.description,
    required this.features,
    required this.tech,
    required this.platforms,
    required this.accent,
    this.image,
    this.icon,
    this.screenshots = const [],
    this.inProgress = false,
    this.playStoreUrl,
    this.appStoreUrl,
    this.webUrl,
    this.pubDevUrl,
    this.githubUrl,
    this.featured = false,
  });
  final String title;
  final String category;
  final String tagline;
  final String description;
  final List<String> features;
  final List<String> tech;
  final List<ProjectPlatform> platforms;
  final Color accent;
  final String? image;
  final String? icon;
  final List<String> screenshots;
  final bool inProgress;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? webUrl;
  final String? pubDevUrl;
  final String? githubUrl;
  final bool featured;

  bool get hasScreens => screenshots.isNotEmpty;

  /// Filter tags used by the projects grid.
  List<String> get tags => [
        if (hasStoreLinks && pubDevUrl == null) 'On Stores',
        if (tech.any((t) => t.toLowerCase().contains('odoo'))) 'Odoo',
        if (tech.any((t) => t.toLowerCase().contains('firebase'))) 'Firebase',
        if (platforms.contains(ProjectPlatform.web)) 'Web',
        if (platforms.contains(ProjectPlatform.package)) 'Open Source',
      ];

  bool get hasStoreLinks =>
      playStoreUrl != null || appStoreUrl != null || webUrl != null || pubDevUrl != null;
}

class Education {
  const Education({
    required this.degree,
    required this.institution,
    required this.year,
    required this.score,
    this.logo,
  });
  final String degree;
  final String institution;
  final String year;
  final String score;
  final String? logo;
}

class Stat {
  const Stat({required this.value, required this.suffix, required this.label});
  final double value;
  final String suffix;
  final String label;
}
