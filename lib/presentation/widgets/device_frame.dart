import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Minimal phone bezel around a screenshot.
class DeviceFrame extends StatelessWidget {
  const DeviceFrame({super.key, required this.image, this.width = 160, this.glow});
  final String image;
  final double width;
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    final radius = width * .14;
    return Container(
      width: width,
      height: width * 2.1,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2138),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFF2B3350), width: 2),
        boxShadow: [
          BoxShadow(color: (glow ?? AppColors.primary).withValues(alpha: .22), blurRadius: 30, offset: const Offset(0, 14)),
          const BoxShadow(color: Colors.black87, blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      padding: EdgeInsets.all(width * .03),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius * .8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover, alignment: Alignment.topCenter),
            Positioned(
              top: width * .04,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: width * .3,
                  height: width * .065,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
