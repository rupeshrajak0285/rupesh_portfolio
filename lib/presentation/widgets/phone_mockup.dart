import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// A device frame rendering a tiny, live Flutter UI (the "preview" of the code window).
class PhoneMockup extends StatelessWidget {
  const PhoneMockup({super.key, this.width = 200});
  final double width;

  @override
  Widget build(BuildContext context) {
    final h = width * 2.05;
    return Container(
      width: width,
      height: h,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2138),
        borderRadius: BorderRadius.circular(width * .17),
        border: Border.all(color: const Color(0xFF2B3350), width: 3),
        boxShadow: [
          BoxShadow(color: AppColors.accent.withValues(alpha: .25), blurRadius: 50, offset: const Offset(0, 20)),
          const BoxShadow(color: Colors.black87, blurRadius: 30, offset: Offset(0, 14)),
        ],
      ),
      padding: const EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * .13),
        child: Container(
          color: const Color(0xFF0B1020),
          child: Stack(
            children: [
              Column(
                children: [
                  // status bar + notch
                  SizedBox(
                    height: 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 14,
                          child: Text('9:41', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                        Container(
                          width: width * .34,
                          height: 16,
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                        ),
                        const Positioned(right: 12, child: Icon(Icons.battery_full_rounded, size: 10, color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(child: _MiniApp(width: width)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniApp extends StatelessWidget {
  const _MiniApp({required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    final s = width / 200; // scale factor
    return Padding(
      padding: EdgeInsets.all(12 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26 * s,
                height: 26 * s,
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
              ),
              SizedBox(width: 8 * s),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, Rupesh 👋', style: GoogleFonts.inter(fontSize: 9 * s, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('Senior Flutter Dev', style: GoogleFonts.inter(fontSize: 7 * s, color: AppColors.textMuted)),
                ],
              ),
              const Spacer(),
              Icon(Icons.notifications_none_rounded, size: 14 * s, color: AppColors.textSecondary),
            ],
          ),
          SizedBox(height: 14 * s),
          // gradient card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12 * s),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.navy, AppColors.primary]),
              borderRadius: BorderRadius.circular(12 * s),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apps shipped', style: GoogleFonts.inter(fontSize: 7 * s, color: Colors.white70)),
                SizedBox(height: 2 * s),
                Text('10+', style: GoogleFonts.spaceGrotesk(fontSize: 20 * s, fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(height: 6 * s),
                Row(
                  children: [
                    for (var i = 0; i < 7; i++)
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 3 * s),
                          height: (6 + (i * 37) % 18) * s,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: i == 5 ? .95 : .35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                            .animate(delay: Duration(milliseconds: 1200 + i * 90))
                            .scaleY(begin: 0, end: 1, alignment: Alignment.bottomCenter, duration: 500.ms, curve: Curves.easeOutBack),
                      ),
                  ],
                ),
              ],
            ),
          ).animate(delay: 900.ms).fadeIn().slideY(begin: .2),
          SizedBox(height: 12 * s),
          Text('Recent builds', style: GoogleFonts.inter(fontSize: 8 * s, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 8 * s),
          for (final (i, item) in const [
            (Icons.phone_in_talk_rounded, 'Chivalry CRM', 'v2.4 · released', AppColors.primary),
            (Icons.monitor_heart_rounded, 'Vizzhy', 'v3.1 · released', AppColors.accent),
            (Icons.show_chart_rounded, 'OctaveHI', 'v1.9 · released', AppColors.warning),
          ].indexed)
            Container(
              margin: EdgeInsets.only(bottom: 7 * s),
              padding: EdgeInsets.all(8 * s),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(9 * s),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22 * s,
                    height: 22 * s,
                    decoration: BoxDecoration(color: item.$4.withValues(alpha: .18), borderRadius: BorderRadius.circular(6 * s)),
                    child: Icon(item.$1, size: 12 * s, color: item.$4),
                  ),
                  SizedBox(width: 8 * s),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.$2, style: GoogleFonts.inter(fontSize: 8 * s, fontWeight: FontWeight.w600, color: Colors.white)),
                      Text(item.$3, style: GoogleFonts.inter(fontSize: 6.5 * s, color: AppColors.textMuted)),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.check_circle_rounded, size: 11 * s, color: AppColors.success),
                ],
              ),
            ).animate(delay: Duration(milliseconds: 1500 + i * 150)).fadeIn().slideX(begin: .2),
          const Spacer(),
          // bottom nav
          Container(
            padding: EdgeInsets.symmetric(vertical: 7 * s),
            decoration: BoxDecoration(color: AppColors.surfaceElevated, borderRadius: BorderRadius.circular(12 * s)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home_rounded, size: 13 * s, color: AppColors.primary),
                Icon(Icons.grid_view_rounded, size: 13 * s, color: AppColors.textMuted),
                Icon(Icons.bar_chart_rounded, size: 13 * s, color: AppColors.textMuted),
                Icon(Icons.person_rounded, size: 13 * s, color: AppColors.textMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
