import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/animated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.getSectionPaddingH(context);
    final padV = Responsive.getSectionPaddingV(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface, AppColors.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            children: [
              FadeInSection(
                child: const SectionTitle(
                  tag: 'Contact',
                  title: "Let's Work Together",
                  subtitle:
                      "Have a project in mind? I'd love to hear about it. Drop me a message and let's build something great.",
                  alignment: CrossAxisAlignment.center,
                ),
              ),
              const SizedBox(height: 60),

              // Social links
              FadeInSection(
                delay: const Duration(milliseconds: 200),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _ContactCard(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: AppStrings.email,
                      color: AppColors.cyan,
                      onTap: openEmail,
                    ),
                    _ContactCard(
                      icon: Icons.code_rounded,
                      label: 'GitHub',
                      value: AppStrings.github,
                      color: AppColors.purple,
                      onTap: () => openEmail(),
                    ),
                    _ContactCard(
                      icon: Icons.work_outline_rounded,
                      label: 'LinkedIn',
                      value: AppStrings.linkedin,
                      color: const Color(0xFF0A66C2),
                      onTap: openLinkedIn,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // CTA
              FadeInSection(
                delay: const Duration(milliseconds: 300),
                child: _buildCTA(context, isMobile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'thirum8190@email.com',
      queryParameters: {
        'subject': 'Flutter Web Contact',
        'body': 'Hello, I want to contact you regarding...',
      },
    );

    if (!await launchUrl(emailUri, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch email');
    }
  }

  Future<void> openLinkedIn() async {
    final Uri url = Uri.parse(AppStrings.linkedin);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch LinkedIn');
    }
  }

  Widget _buildCTA(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(48),
      width: isMobile ? double.infinity : 640,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyan.withValues(alpha: 0.06),
            AppColors.purple.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            '🚀',
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 16),
          Text(
            'Available for Flutter Projects',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Looking for a Flutter developer for your next project?\nLet\'s connect and discuss how I can help.',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          AnimatedGradientButton(
            label: 'Get In Touch',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 220,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color, size: 22),
              ),
              const SizedBox(height: 16),
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? widget.color : Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
