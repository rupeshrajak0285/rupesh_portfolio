import 'package:flutter/material.dart';

/// Flutter / Dart brand-inspired palette.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF080C16);
  static const Color surface = Color(0xFF0E1424);
  static const Color surfaceElevated = Color(0xFF151D31);
  static const Color border = Color(0x1AFFFFFF);
  static const Color borderStrong = Color(0x33FFFFFF);

  /// Flutter sky blue
  static const Color primary = Color(0xFF13B9FD);
  /// Flutter light blue
  static const Color secondary = Color(0xFF54C5F8);
  /// Flutter navy
  static const Color navy = Color(0xFF0553B1);
  /// Dart teal
  static const Color accent = Color(0xFF00D2B4);
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFFC857);
  static const Color pink = Color(0xFFFF6BCB);

  static const Color textPrimary = Color(0xFFF3F6FB);
  static const Color textSecondary = Color(0xFFA6B0C3);
  static const Color textMuted = Color(0xFF66708A);

  // Syntax colours (One Dark inspired)
  static const Color codeKeyword = Color(0xFFC678DD);
  static const Color codeType = Color(0xFFE5C07B);
  static const Color codeString = Color(0xFF98C379);
  static const Color codeComment = Color(0xFF5C6370);
  static const Color codeFunction = Color(0xFF61AFEF);
  static const Color codeNumber = Color(0xFFD19A66);
  static const Color codeText = Color(0xFFABB2BF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [navy, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF54C5F8), Color(0xFF13B9FD), Color(0xFF00D2B4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x12FFFFFF), Color(0x04FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
