import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0A0A0F);
  static const surface = Color(0xFF111118);
  static const surfaceElevated = Color(0xFF1A1A24);
  static const border = Color(0xFF1E1E2E);
  static const borderActive = Color(0xFF2A2A3E);

  static const cyan = Color(0xFF00D4FF);
  static const cyanDim = Color(0xFF00A8CC);
  static const purple = Color(0xFF7B2FBE);
  static const purpleLight = Color(0xFF9B4FDE);
  static const green = Color(0xFF00FF88);
  static const orange = Color(0xFFFF6B35);

  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFB0B0C0);
  static const textMuted = Color(0xFF6060780);

  static const gradientCyan = LinearGradient(
    colors: [cyan, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const gradientPurple = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppSizes {
  static const double navHeight = 70;
  static const double maxWidth = 1200;
  static const double sectionPadH = 80;
  static const double sectionPadV = 100;

  static double breakpointMobile = 600;
  static double breakpointTablet = 900;
  static double breakpointDesktop = 1200;
}

class AppStrings {
  // Personal
  static const String name = 'Thirumalai S';
  static const String title = 'Flutter Developer';
  static const String tagline =
      'Building high-performance cross-platform\nmobile applications with Flutter.';
  static const String email = 'thirum8190@email.com';
  static const String github = 'https://github.com/tomaszgajda';
  static const String linkedin = "linkedin.com/in/thiru-malai-b09b72255";
  static const String experience = '4+ Years Experience';
  static const String platforms = 'Android & iOS';

  // Nav
  static const List<String> navItems = [
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];
}

class AppAssets {
  static const String profilePic = 'assets/images/thiru.png';
}
