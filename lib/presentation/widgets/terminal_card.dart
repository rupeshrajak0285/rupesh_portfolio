import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// Terminal window showing a `flutter doctor`-style summary that types in line by line.
class TerminalCard extends StatelessWidget {
  const TerminalCard({super.key});

  static const _lines = [
    ('\$ ', 'flutter doctor --rupesh', AppColors.textPrimary),
    ('[✓] ', 'Flutter (Channel stable, 3.5+ years, Android · iOS · Web)', AppColors.success),
    ('[✓] ', 'Architecture (MVVM, Clean, BLoC, Provider, GetX, Riverpod)', AppColors.success),
    ('[✓] ', 'Native (Platform Channels, Twilio Voice, CallKit, PushKit, BLE)', AppColors.success),
    ('[✓] ', 'Backend (Firebase, REST, Odoo JSON-RPC / XML-RPC, WebSocket)', AppColors.success),
    ('[✓] ', 'Release (Play Store, App Store, R8, Flavors, Shorebird OTA)', AppColors.success),
    ('[✓] ', 'Open source (json_form_engine on pub.dev)', AppColors.success),
    ('', '• No issues found!', AppColors.primary),
  ];

  @override
  Widget build(BuildContext context) {
    final mono = GoogleFonts.jetBrainsMono(fontSize: 12.5, height: 1.7, color: AppColors.codeText);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1020),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderStrong),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(color: Color(0xFF111830), border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                for (final c in const [Color(0xFFFF5F57), Color(0xFFFEBC2E), Color(0xFF28C840)])
                  Container(width: 11, height: 11, margin: const EdgeInsets.only(right: 7), decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                const Spacer(),
                Text('zsh — 80×24', style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppColors.textMuted)),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (i, l) in _lines.indexed)
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(text: l.$1, style: TextStyle(color: l.$3, fontWeight: FontWeight.w700)),
                      TextSpan(text: l.$2, style: TextStyle(color: i == 0 ? AppColors.textPrimary : (i == _lines.length - 1 ? AppColors.primary : AppColors.codeText))),
                    ]),
                    style: mono,
                  ).animate(delay: Duration(milliseconds: 300 + i * 260)).fadeIn(duration: 250.ms).slideX(begin: .05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
