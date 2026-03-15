import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.getSectionPaddingH(context);

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            children: [
              Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 32),
              Row(
                children: [
                  // Logo
                  Text(
                    'Thiru.dev',
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '© 2024 Thirumalai S. All rights reserved.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      color: const Color(0xFF505068),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Built with Flutter Web ❤️',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  color: AppColors.cyan.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
