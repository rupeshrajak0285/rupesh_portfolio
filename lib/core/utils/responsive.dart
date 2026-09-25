import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static const double mobileBreakpoint = 700;
  static const double tabletBreakpoint = 1100;
  static const double maxContentWidth = 1240;

  static DeviceType of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobileBreakpoint) return DeviceType.mobile;
    if (width < tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) => of(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) => of(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) => of(context) == DeviceType.desktop;

  static double horizontalPadding(BuildContext context) {
    switch (of(context)) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.tablet:
        return 40;
      case DeviceType.desktop:
        return 64;
    }
  }

  /// Picks a value depending on the current device type.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (of(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }
}
