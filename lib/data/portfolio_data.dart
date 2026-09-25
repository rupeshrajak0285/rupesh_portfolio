import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/theme/app_colors.dart';
import 'models/models.dart';

/// Single source of truth for all résumé content shown on the site.
class PortfolioData {
  PortfolioData._();

  static const String name = 'Rupesh Rajak';
  static const String firstName = 'Rupesh';
  static const String role = 'Senior Flutter Developer';
  static const String location = 'India';
  static const String email = 'rupesh.rajak.flutter@gmail.com';
  static const String phone = '+91 9516687164';
  static const String phoneRaw = '+919516687164';
  static const String linkedin = 'https://www.linkedin.com/in/rupesh-rajak-38ab9132a/';
  static const String github = 'https://github.com/rupeshrajak0285';
  static const String pubDev = 'https://pub.dev/packages/json_form_engine';
  static const String resumeAsset = 'assets/docs/Rupesh_Rajak_Resume.pdf';
  static const String siteUrl = 'https://rupeshflutter.web.app';

  static const List<String> heroTitles = [
    'Senior Flutter Developer',
    'Cross-Platform Architect',
    'Native Integration Specialist',
    'Open-Source Contributor',
  ];

  static const String summary =
      'Senior Flutter Developer with 3.5+ years of experience architecting, building and shipping '
      'production-grade cross-platform applications across CRM, healthcare, fintech and EdTech. '
      'I own the complete product lifecycle, from requirement analysis and architecture design to '
      'App Store and Play Store release management.';

  static const String aboutLong =
      'I specialise in deep native platform integration via Platform Channels: Twilio Voice VoIP, '
      'CallKit, PushKit and IoT/BLE health devices. I have built ERP integration layers for Odoo '
      '(JSON-RPC / XML-RPC) and champion clean, scalable MVVM and Clean Architecture with BLoC, '
      'Provider, GetX and Riverpod.\n\n'
      'I am recognised for solving hard production issues, from release-only native crashes to '
      'performance bottlenecks, mentoring developers, and publishing open-source packages on pub.dev.';

  static const List<Stat> stats = [
    Stat(value: 3.5, suffix: '+', label: 'Years Experience'),
    Stat(value: 14, suffix: '+', label: 'Apps Built'),
    Stat(value: 3, suffix: '', label: 'Industries'),
    Stat(value: 1, suffix: '', label: 'pub.dev Package'),
  ];

  static final List<SocialLink> socials = [
    SocialLink(label: 'LinkedIn', url: linkedin, icon: FontAwesomeIcons.linkedinIn.data),
    SocialLink(label: 'GitHub', url: github, icon: FontAwesomeIcons.github.data),
    SocialLink(label: 'pub.dev', url: pubDev, icon: FontAwesomeIcons.dartLang.data),
    SocialLink(label: 'Email', url: 'mailto:$email', icon: FontAwesomeIcons.envelope.data),
  ];

  static final List<SkillGroup> skillGroups = [
    SkillGroup(
      title: 'Languages & Frameworks',
      icon: FontAwesomeIcons.code.data,
      color: AppColors.primary,
      skills: ['Dart', 'Flutter', 'Android', 'iOS', 'Flutter Web'],
    ),
    SkillGroup(
      title: 'State Management',
      icon: FontAwesomeIcons.layerGroup.data,
      color: AppColors.secondary,
      skills: ['BLoC', 'Provider', 'GetX', 'Riverpod'],
    ),
    SkillGroup(
      title: 'Architecture',
      icon: FontAwesomeIcons.diagramProject.data,
      color: AppColors.accent,
      skills: [
        'MVVM',
        'Clean Architecture',
        'Modular Codebase',
        'Responsive Design',
        'Offline-First',
      ],
    ),
    SkillGroup(
      title: 'API Integration',
      icon: Icons.cable_rounded,
      color: AppColors.success,
      skills: [
        'REST APIs',
        'JSON-RPC',
        'XML-RPC (Odoo ERP)',
        'WebSocket',
        'Dio',
        'HTTP',
        'Postman',
        'Token Auth',
      ],
    ),
    SkillGroup(
      title: 'Firebase',
      icon: FontAwesomeIcons.fire.data,
      color: AppColors.warning,
      skills: [
        'Authentication',
        'Cloud Messaging',
        'Firestore',
        'Realtime Database',
        'Crashlytics',
        'Hosting',
      ],
    ),
    SkillGroup(
      title: 'Native Integration',
      icon: Icons.memory_rounded,
      color: AppColors.primary,
      skills: [
        'Platform Channels',
        'Method Channels',
        'Twilio Voice SDK',
        'CallKit',
        'PushKit',
        'Isolates',
        'IoT / BLE Devices',
      ],
    ),
    SkillGroup(
      title: 'Tools',
      icon: FontAwesomeIcons.screwdriverWrench.data,
      color: AppColors.secondary,
      skills: [
        'Android Studio',
        'Xcode',
        'VS Code',
        'Git & GitHub',
        'Firebase Console',
        'Google Maps',
        'Flutter DevTools',
        'Shorebird Code Push',
      ],
    ),
    SkillGroup(
      title: 'Deployment & DevOps',
      icon: FontAwesomeIcons.rocket.data,
      color: AppColors.accent,
      skills: [
        'Google Play Store',
        'Apple App Store',
        'App Store Connect',
        'TestFlight',
        'Code Signing',
        'ProGuard / R8',
        'Build Flavors',
        'OTA Updates',
      ],
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      role: 'Senior Flutter Developer',
      company: 'Pragmatic Techsoft Pvt. Ltd. (Pragtech)',
      companyUrl: 'https://www.pragtech.co.in',
      period: 'Jun 2026 – Present',
      location: 'India',
      isCurrent: true,
      tech: ['Flutter', 'Odoo 18', 'Twilio Voice', 'CallKit', 'PushKit', 'FCM', 'JSON-RPC'],
      highlights: [
        'Leading end-to-end development of Chivalry CRM, a cross-platform Odoo CRM product with lead and sales pipeline management, quotations, chatter and WhatsApp messaging, owning architecture, native integration and store releases single-handedly.',
        'Architected in-app VoIP calling by integrating the Twilio Voice SDK natively on both platforms via Platform Channels: outbound dialer, incoming calls with CallKit (iOS) and full-screen call notifications (Android), and real-time agent availability synced with the server.',
        'Designed a secure Odoo 18 integration layer using JSON-RPC / XML-RPC with session-based authentication and per-user API key management.',
        'Engineered push-driven incoming call delivery using FCM (Android) and APNs / PushKit (iOS), ensuring reliable call alerts even when the app is terminated.',
        'Own complete release engineering for the company: Android keystore signing, ProGuard / R8 configuration, App Store Connect setup and production submissions to both stores.',
        'Diagnosed and resolved a critical release-only native crash (R8 stripping Twilio JNI symbols) through logcat / tombstone analysis and custom ProGuard keep rules, unblocking the production launch.',
        'Published and maintain json_form_engine, an open-source JSON-driven dynamic form builder on pub.dev, adopted across internal projects.',
        'Delivering a portfolio of Odoo-integrated apps in parallel: a delivery driver application and SocietyDesk, a dual-portal apartment maintenance product built on Odoo Helpdesk.',
      ],
    ),
    Experience(
      role: 'Senior Flutter Developer',
      company: 'Vardhan SK Health Care Pvt. Ltd. (Vizzhy Inc)',
      logo: 'assets/images/vizzhy_inc.png',
      period: 'Nov 2025 – May 2026',
      location: 'India',
      tech: ['Flutter', 'IoT / BLE', 'Azure SDK', 'Method Channels', 'Shorebird', 'Build Flavors'],
      highlights: [
        'Owned end-to-end development of the Vizzhy health and wellness platform: UI implementation, API integration, native device connectivity and releases to both stores.',
        'Integrated IoT-based health devices (glucose monitor, BP monitor, weight scale) with the Flutter app, enabling continuous metabolic health tracking.',
        'Engineered real-time health data streaming with the Azure SDK through Method Channels, ensuring secure, low-latency native-to-Flutter data flow.',
        'Established multi-environment build infrastructure (Dev, Staging, Production) with flavor-based configuration, signing and provisioning.',
        'Introduced Shorebird Code Push for over-the-air updates, cutting bug-fix turnaround from store-review days to minutes.',
        'Drove performance optimisation across API handling, widget rebuilds and memory usage, measurably improving responsiveness and stability.',
      ],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'LOGIMONK Technologies',
      logo: 'assets/images/logimonk.png',
      period: 'Nov 2022 – Aug 2025',
      location: 'India',
      tech: ['Flutter', 'Firebase', 'MVVM', 'REST', 'WebSocket', 'Play Store', 'App Store'],
      highlights: [
        'Delivered and maintained multiple production apps across mobile and web: OctaveHI (fintech), Aspirant League (EdTech) and PIMS HQ (enterprise web).',
        'Owned features end-to-end: UI implementation, API integration, testing and deployment to Google Play Store and Apple App Store.',
        'Championed MVVM architecture and clean code principles across projects, improving scalability, maintainability and testability.',
        'Integrated Firebase Authentication, Firestore, Cloud Messaging and Realtime Database for real-time communication and secure data management.',
        'Built a library of custom reusable widgets that standardised UI/UX and accelerated feature delivery for the whole team.',
        'Mentored junior developers through structured code reviews, best-practice guidance and hands-on debugging support.',
        'Led performance analysis, profiling frame rates, load times and memory, and drove fixes to keep apps at 60fps.',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Chivalry CRM',
      category: 'CRM · VoIP',
      tagline: 'Odoo 18 sales CRM with fully native VoIP calling.',
      description:
          'Cross-platform Odoo CRM product with stage-filtered lead pipeline, quotations, chatter, WhatsApp messaging and one-tap Twilio VoIP calling with a native incoming-call experience on both platforms. Owned end-to-end: architecture, native integration and store releases.',
      features: [
        'Twilio Voice SDK via Platform Channels',
        'CallKit (iOS) & full-screen call UI (Android)',
        'Push-driven call delivery with FCM / PushKit',
        'Odoo JSON-RPC / XML-RPC integration layer',
        'Lead pipeline, quotations, chatter & WhatsApp',
      ],
      tech: ['Flutter', 'Odoo 18', 'Twilio', 'CallKit', 'PushKit', 'FCM'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.primary,
      featured: true,
    ),
    Project(
      title: 'Vizzhy',
      category: 'Healthcare · IoT',
      tagline: 'Metabolic health platform powered by connected devices.',
      description:
          'Digital health platform for metabolic health monitoring using IoT devices (glucose, blood pressure and weight monitors) with real-time data streaming through the Azure SDK. Live on both stores.',
      features: [
        'BLE health device integration',
        'Real-time streaming via Method Channels',
        'Dev / Staging / Prod build flavors',
        'Shorebird OTA updates',
      ],
      tech: ['Flutter', 'IoT / BLE', 'Azure', 'Firebase', 'Shorebird'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.accent,
      icon: 'assets/images/screens/vizzhy/icon.png',
      screenshots: ['assets/images/screens/vizzhy/s1.png', 'assets/images/screens/vizzhy/s2.png', 'assets/images/screens/vizzhy/s3.png', 'assets/images/screens/vizzhy/s4.png', 'assets/images/screens/vizzhy/s5.png', 'assets/images/screens/vizzhy/s6.png'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.vizzhy.multiomics',
      appStoreUrl: 'https://apps.apple.com/in/app/vizzhy/id6677031163',
      featured: true,
    ),
    Project(
      title: 'OctaveHI · Investor Portal',
      category: 'Fintech',
      tagline: 'Dual-portal investment platform for investors and advisors.',
      description:
          'Investment platform with Investor and Advisor portals, secure API authentication, FCM push alerts and dynamic graph visualisations for real-time portfolio performance and analytics.',
      features: [
        'Dual user portals (Investor / Advisor)',
        'Real-time portfolio charts',
        'Secure token-based authentication',
        'FCM push notifications',
      ],
      tech: ['Flutter', 'REST', 'FCM', 'Charts', 'MVVM'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.secondary,
      icon: 'assets/images/screens/octavehi/icon.png',
      screenshots: ['assets/images/screens/octavehi/s1.png', 'assets/images/screens/octavehi/s2.png', 'assets/images/screens/octavehi/s3.png', 'assets/images/screens/octavehi/s4.png', 'assets/images/screens/octavehi/s5.png', 'assets/images/screens/octavehi/s6.png'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.octavehi.app',
      appStoreUrl: 'https://apps.apple.com/in/app/octavehi/id1592076532',
      featured: true,
    ),
    Project(
      title: 'Delivery Driver App',
      category: 'Logistics · Odoo',
      tagline: 'Driver-side delivery app with routing, proof of delivery and payments.',
      description:
          'Odoo-integrated delivery application for drivers: open and broadcast jobs, order detail, route preview with turn-by-turn navigation, signature and photo proof of delivery, code-based delivery confirmation and payment collection.',
      features: [
        'Open jobs, broadcast orders & availability toggle',
        'Route preview & turn-by-turn navigation',
        'Signature pad + delivery photo proof',
        'Collect payment & delivery-code confirmation',
        'Reject / report-issue flows with reasons',
        'Background location tracking',
      ],
      tech: ['Flutter', 'Odoo', 'Google Maps', 'Geolocation', 'Camera', 'BLoC'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.warning,
      icon: 'assets/images/screens/delivery/icon.png',
      screenshots: ['assets/images/screens/delivery/s1.png', 'assets/images/screens/delivery/s2.png', 'assets/images/screens/delivery/s3.png', 'assets/images/screens/delivery/s4.png', 'assets/images/screens/delivery/s5.png', 'assets/images/screens/delivery/s6.png', 'assets/images/screens/delivery/s7.png'],
      featured: true,
    ),
    Project(
      title: 'Fastpeer AI',
      category: 'AI · Voice',
      tagline: 'Voice AI chatbot with lifelike avatar videos.',
      description:
          'Voice AI chatbot combining the OpenAI API, D-ID avatar videos and text-to-speech pipelines, optimised for smooth cross-platform performance.',
      features: [
        'OpenAI conversational engine',
        'D-ID avatar video generation',
        'Text-to-speech pipeline',
        'Chat history & multi-modal prompts',
      ],
      tech: ['Flutter', 'OpenAI', 'D-ID', 'TTS', 'REST'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.pink,
      icon: 'assets/images/screens/fastpeer_ai/icon.png',
      screenshots: ['assets/images/screens/fastpeer_ai/s1.png', 'assets/images/screens/fastpeer_ai/s2.png', 'assets/images/screens/fastpeer_ai/s3.png', 'assets/images/screens/fastpeer_ai/s4.png', 'assets/images/screens/fastpeer_ai/s5.png', 'assets/images/screens/fastpeer_ai/s6.png'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.fastpeer.ai',
      appStoreUrl: 'https://apps.apple.com/gb/app/fastpeer-ai/id6742652329',
    ),
    Project(
      title: 'Fastpeer Business AI',
      category: 'AI · Business',
      tagline: 'Business edition of the Fastpeer AI assistant.',
      description:
          'Business-focused companion to Fastpeer AI, sharing the same OpenAI and avatar pipeline with a workflow tailored for teams. Published on both stores.',
      features: [
        'Shared AI core with Fastpeer AI',
        'Business-oriented assistant flows',
        'Avatar video + voice responses',
        'Play Store & App Store releases',
      ],
      tech: ['Flutter', 'OpenAI', 'D-ID', 'REST'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.pink,
      icon: 'assets/images/screens/fastpeer_business/icon.png',
      screenshots: ['assets/images/screens/fastpeer_business/s1.png', 'assets/images/screens/fastpeer_business/s2.png', 'assets/images/screens/fastpeer_business/s3.png', 'assets/images/screens/fastpeer_business/s4.png', 'assets/images/screens/fastpeer_business/s5.png', 'assets/images/screens/fastpeer_business/s6.png'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.fastpeerbusiness',
      appStoreUrl: 'https://apps.apple.com/in/app/fastpeer-business/id6742652520',
    ),
    Project(
      title: 'Aspirant League',
      category: 'EdTech',
      tagline: 'Real-time competitive exam prep with live gameplay.',
      description:
          'WebSocket-based real-time gameplay, exam engine and analytics dashboards for competitive exam preparation.',
      features: [
        'WebSocket real-time gameplay',
        'Exam engine with timers',
        'Analytics dashboards',
        'Firebase Auth & FCM',
      ],
      tech: ['Flutter', 'WebSocket', 'Firebase', 'Analytics'],
      platforms: [ProjectPlatform.android],
      accent: AppColors.primary,
      icon: 'assets/images/screens/aspirant_league/icon.png',
      screenshots: ['assets/images/screens/aspirant_league/s2.png', 'assets/images/screens/aspirant_league/s3.png', 'assets/images/screens/aspirant_league/s4.png', 'assets/images/screens/aspirant_league/s5.png', 'assets/images/screens/aspirant_league/s6.png'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.aspirantleague.app',
    ),
    Project(
      title: 'PIMS HQ',
      category: 'Enterprise · Web',
      tagline: 'Enterprise dashboards and invoicing on Flutter Web.',
      description:
          'Dashboards, invoicing and real-time data modules with dynamic API rendering, clean architecture and fully responsive web layouts.',
      features: [
        'Responsive Flutter Web layouts',
        'Dynamic API-driven rendering',
        'Invoicing & reporting modules',
        'Clean architecture',
      ],
      tech: ['Flutter Web', 'REST', 'Clean Architecture', 'Responsive'],
      platforms: [ProjectPlatform.web],
      accent: AppColors.warning,
      image: 'assets/images/pims_project.png',
      webUrl: 'https://www.pimshq.com/',
    ),
    Project(
      title: 'SocietyDesk',
      category: 'PropTech · Odoo',
      tagline: 'Dual-portal apartment maintenance built on Odoo Helpdesk.',
      description:
          'One Flutter app, two portals. Residents raise maintenance tickets with photos, track status, approve work, pay and rate. Technicians receive assigned jobs, check in, complete with proof photos and collect payment. Runs on the official Odoo Helpdesk via JSON-RPC with an offline-first local store.',
      features: [
        'Resident & technician portals',
        'Odoo Helpdesk ticket sync (JSON-RPC)',
        'Photo attachments & chatter updates',
        'Parts ordering via stock pickings',
        'Offline-first MVVM + BLoC + Repository',
      ],
      tech: ['Flutter', 'Odoo Helpdesk', 'JSON-RPC', 'BLoC', 'SQLite'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.secondary,
      icon: 'assets/images/screens/societydesk/icon.png',
    ),
    Project(
      title: 'LeadTracker Pro',
      category: 'Sales · Odoo',
      tagline: 'Sales-management app with AI-assisted lead assignment.',
      description:
          'Mobile sales-management app for admins and salespeople with AI-assisted lead assignment, accept / reject workflow, visit tracking and live location on an Odoo 19 JSON-RPC backend. Clean Architecture + MVVM with BLoC events and states.',
      features: [
        'Admin & salesperson roles',
        'AI-assisted lead assignment',
        'Accept / reject with reasons & reassignment',
        'Visit workflow & live tracking',
        'Odoo 19 JSON-RPC backend',
      ],
      tech: ['Flutter', 'Odoo 19', 'BLoC', 'Clean Architecture', 'Maps'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.primary,
      icon: 'assets/images/screens/leadtracker/icon.png',
    ),
    Project(
      title: 'RoomRadar',
      category: 'PropTech · Firebase',
      tagline: 'Find rooms and rentals near you, right on the map.',
      description:
          'Flutter + Firebase + Google Maps app with geohash radius search over approved listings, Google Sign-In, property listings with photo upload and GPS capture, owner contact via call / WhatsApp, and an admin dashboard that also runs on Flutter Web.',
      features: [
        'Geohash radius search (1–10 km)',
        'Firebase Auth, Firestore & Storage',
        'Add / manage properties with photos & GPS',
        'Admin approvals & user blocking',
        'GoRouter, BLoC, GetIt / Injectable DI',
      ],
      tech: ['Flutter', 'Firebase', 'Google Maps', 'BLoC', 'GoRouter'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios, ProjectPlatform.web],
      accent: AppColors.accent,
      icon: 'assets/images/screens/room_radar/icon.png',
    ),
    Project(
      title: 'Fitness Studio Management',
      category: 'Fitness · Odoo',
      tagline: 'Members, trainers and admin in one app.',
      description:
          'Fitness studio management app bringing members, trainers and studio admins into a single Flutter codebase with role-based dashboards.',
      features: ['Member, trainer & admin roles', 'Dashboards per role', 'Registration & login flows'],
      tech: ['Flutter', 'Odoo', 'MVVM'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.success,
      icon: 'assets/images/screens/fitness/icon.png',
      inProgress: true,
    ),
    Project(
      title: 'Spa & Salon All-in-One',
      category: 'Lifestyle · Odoo',
      tagline: 'All-in-one spa and salon mobile app.',
      description: 'Mobile app for spa and salon businesses built on the Pragtech Odoo stack.',
      features: ['Odoo-backed data layer', 'Role-based flows', 'Reusable widget library'],
      tech: ['Flutter', 'Odoo', 'JSON-RPC'],
      platforms: [ProjectPlatform.android, ProjectPlatform.ios],
      accent: AppColors.pink,
      icon: 'assets/images/screens/spa_salon/icon.png',
      inProgress: true,
    ),
    Project(
      title: 'json_form_engine',
      category: 'Open Source · pub.dev',
      tagline: 'JSON-driven dynamic form builder for Flutter.',
      description:
          'Validated, conditional, multi-step forms with 50+ field types, theming and localisation, plus built-in image, camera and file pickers. Published and actively maintained on pub.dev.',
      features: [
        '50+ field types',
        'Conditional & multi-step forms',
        'Image, camera & file pickers',
        'Theming & localisation',
      ],
      tech: ['Dart', 'Flutter', 'pub.dev'],
      platforms: [ProjectPlatform.package],
      accent: AppColors.accent,
      pubDevUrl: pubDev,
      githubUrl: '$github/json_form_engine',
    ),
  ];

  static const List<Education> education = [
    Education(
      degree: 'B.E. Electronics & Communication Engineering',
      institution: 'Rajiv Gandhi Proudyogiki Vishwavidyalaya (RGPV), Bhopal',
      year: '2020',
      score: 'CGPA 7.6',
      logo: 'assets/images/rgpv_logo.png',
    ),
    Education(
      degree: 'Higher Secondary (12th)',
      institution: 'MP Board of Secondary Education, Bhopal',
      year: '2016',
      score: '88%',
      logo: 'assets/images/mp_board_logo.png',
    ),
    Education(
      degree: 'Secondary (10th)',
      institution: 'MP Board of Secondary Education, Bhopal',
      year: '2014',
      score: '82%',
      logo: 'assets/images/mp_board_logo.png',
    ),
  ];
}
