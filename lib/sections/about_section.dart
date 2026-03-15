import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padH = Responsive.getSectionPaddingH(context);
    final padV = Responsive.getSectionPaddingV(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: FadeInSection(
            child: const SectionTitle(
              tag: 'About Me',
              title: 'Passionate Flutter Developer',
              subtitle:
                  'I craft beautiful, high-performance mobile experiences that users love — across Android and iOS.',
            ),
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 3,
          child: FadeInSection(
            delay: const Duration(milliseconds: 200),
            slideFrom: const Offset(40, 0),
            child: _buildAboutContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInSection(
          child: const SectionTitle(
            tag: 'About Me',
            title: 'Passionate Flutter\nDeveloper',
          ),
        ),
        const SizedBox(height: 40),
        FadeInSection(
          delay: const Duration(milliseconds: 200),
          child: _buildAboutContent(context),
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'With over 4 years of Flutter development experience, I specialize in building '
          'scalable, production-ready mobile applications for Android and iOS. I\'ve worked '
          'on real-world applications that serve thousands of users, with a strong emphasis '
          'on clean architecture and code maintainability.',
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          'My expertise spans state management with GetX and BLoC, RESTful API integration, '
          'Firebase services, and crafting smooth, responsive UIs. I\'m passionate about '
          'delivering pixel-perfect interfaces that align with modern design principles.',
        ),
        const SizedBox(height: 36),

        // Highlights grid
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildHighlight(Icons.architecture, 'Clean Architecture'),
            _buildHighlight(Icons.devices, 'Cross-Platform'),
            _buildHighlight(Icons.speed, 'Performance Focus'),
            _buildHighlight(Icons.api, 'API Integration'),
            _buildHighlight(Icons.layers, 'State Management'),
            _buildHighlight(Icons.palette, 'Responsive UI'),
          ],
        ),

        const SizedBox(height: 36),

        // Timeline chips
        _buildTimelineChip(),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.8,
      ),
    );
  }

  Widget _buildHighlight(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.cyan, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineChip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyan.withValues(alpha: 0.08),
            AppColors.purple.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.work_outline_rounded,
                color: AppColors.cyan, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter Developer — 4 Years',
                  style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Android & iOS • Production Apps',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
