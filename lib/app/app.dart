import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thirumalai S - Flutter Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const HomeScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0A0F),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00D4FF),
        secondary: Color(0xFF7B2FBE),
        surface: Color(0xFF111118),
        onPrimary: Color(0xFF0A0A0F),
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.syne(
          fontSize: 56, // Reduced from 72
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -2,
        ),
        displayMedium: GoogleFonts.syne(
          fontSize: 40, // Reduced from 48
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -1.5,
        ),
        displaySmall: GoogleFonts.syne(
          fontSize: 28, // Reduced from 36
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -1,
        ),
        headlineLarge: GoogleFonts.syne(
          fontSize: 24, // Reduced from 28
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.spaceGrotesk(
          fontSize: 16, // Reduced from 18
          color: const Color(0xFFB0B0C0),
          height: 1.7,
        ),
        bodyMedium: GoogleFonts.spaceGrotesk(
          fontSize: 14, // Reduced from 15
          color: const Color(0xFF8888A0),
          height: 1.6,
        ),
        labelLarge: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: const Color(0xFF00D4FF),
        ),
      ),
      useMaterial3: true,
    );
  }
}
