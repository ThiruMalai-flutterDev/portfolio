import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return DeviceType.mobile;
    if (width < 1024) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  static double getFontScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 0.6;
    if (width < 1024) return 0.8;
    return 1.0;
  }

  static double getSectionPaddingH(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 20;
    if (width < 1024) return 48;
    return 80;
  }

  static double getSectionPaddingV(BuildContext context) {
    if (isMobile(context)) return 60;
    if (isTablet(context)) return 80;
    return 100;
  }

  // Responsive font sizes
  static double getDisplayLargeFontSize(BuildContext context) {
    if (isMobile(context)) return 48;
    if (isTablet(context)) return 56;
    return 72;
  }

  static double getDisplayMediumFontSize(BuildContext context) {
    if (isMobile(context)) return 32;
    if (isTablet(context)) return 40;
    return 48;
  }

  static double getDisplaySmallFontSize(BuildContext context) {
    if (isMobile(context)) return 24;
    if (isTablet(context)) return 30;
    return 36;
  }

  static double getHeadlineLargeFontSize(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 24;
    return 28;
  }

  static double getBodyLargeFontSize(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 17;
    return 18;
  }

  static double getBodyMediumFontSize(BuildContext context) {
    if (isMobile(context)) return 14;
    if (isTablet(context)) return 14.5;
    return 15;
  }

  static double getLabelLargeFontSize(BuildContext context) {
    return 14; // Same for all
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) return mobile;
        if (constraints.maxWidth < 1024) return tablet ?? desktop;
        return desktop;
      },
    );
  }
}
