import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.getSectionPaddingH(context);
    final padV = Responsive.getSectionPaddingV(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FadeInSection(
                child: SectionTitle(
                  tag: 'Experience',
                  title: 'Career Journey',
                  subtitle:
                      'My professional experience building production Flutter applications.',
                ),
              ),
              const SizedBox(height: 60),
              FadeInSection(
                delay: const Duration(milliseconds: 200),
                child: _buildTimeline(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final experiences = [
      const _ExperienceData(
        role: 'Flutter Developer',
        company: 'TOUCHTiER TECHNOLOGY',
        period: '2024 — 2026',
        duration: '2 Years',
        type: 'Full-time',
        description:
            'Developed full-stack Flutter frontends for mobile diagnostic and recycling apps. Built hardware-testing workflows, diagnostic API integrations, and pickup-scheduling UIs for Android and iOS.',
        achievements: [
          'Built entire Flutter frontend for CityMobile app',
          'Integrated diagnostic APIs for hardware testing',
          'Delivered production-ready Android & iOS builds',
          'Implemented BLoC architecture for state management',
        ],
        techStack: ['Flutter', 'BLoC', 'REST API', 'Firebase', 'Dart'],
        color: AppColors.cyan,
      ),
      const _ExperienceData(
        role: 'Flutter Developer',
        company: 'Brazien Technologies Private Limited',
        period: '2023 — 2024',
        duration: '1 Year',
        type: 'Full-time',
        description:
            'Supported frontend development and API integration for a sports management mobile application. Focused on implementing UI screens and managing complex app state.',
        achievements: [
          'Implemented multiple feature UI screens',
          'Integrated backend REST APIs with Dio',
          'Managed app state with GetX',
          'Contributed to cross-functional delivery',
        ],
        techStack: ['Flutter', 'GetX', 'Dio', 'REST API', 'Dart'],
        color: AppColors.purple,
      ),
      const _ExperienceData(
        role: 'Flutter Developer',
        company: 'TeckZy Research Analytics IT Solutions Pvt. Ltd.',
        period: '2022 — 2023',
        duration: '1 Year',
        type: 'Full-time',
        description:
            'Started my professional Flutter journey during focused on mobile development fundamentals, clean architecture patterns, and building my first production-grade apps.',
        achievements: [
          'Learned Flutter from fundamentals to production',
          'Built product catalog app with CRUD operations',
          'Applied GetX and Dio for API-driven apps',
          'Gained exposure to agile workflows',
        ],
        techStack: ['Flutter', 'Dart', 'GetX', 'Dio', 'Git'],
        color: AppColors.green,
      ),
    ];

    return Column(
      children: experiences.asMap().entries.map((entry) {
        final i = entry.key;
        final exp = entry.value;
        final isLast = i == experiences.length - 1;
        final isMobile = Responsive.isMobile(context);

        return isMobile
            ? Column(
                children: [
                  // Centered timeline dot
                  Center(
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: exp.color,
                        boxShadow: [
                          BoxShadow(
                            color: exp.color.withValues(alpha: 0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Card
                  Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 24 : 32),
                    child: _ExperienceCard(exp: exp),
                  ),
                ],
              )
            : IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline spine
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: exp.color,
                            boxShadow: [
                              BoxShadow(
                                color: exp.color.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 1,
                              color: AppColors.border,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 24),

                    // Card
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 24 : 32),
                        child: _ExperienceCard(exp: exp),
                      ),
                    ),
                  ],
                ),
              );
      }).toList(),
    );
  }
}

class _ExperienceData {
  final String role;
  final String company;
  final String period;
  final String duration;
  final String type;
  final String description;
  final List<String> achievements;
  final List<String> techStack;
  final Color color;

  const _ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.duration,
    required this.type,
    required this.description,
    required this.achievements,
    required this.techStack,
    required this.color,
  });
}

class _ExperienceCard extends StatefulWidget {
  final _ExperienceData exp;
  const _ExperienceCard({required this.exp});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.exp.color;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? color.withValues(alpha: 0.3) : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.exp.role,
                          maxLines: Responsive.isMobile(context) ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.syne(
                            fontSize: Responsive.isMobile(context) ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.exp.company,
                          maxLines: Responsive.isMobile(context) ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.exp.period,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: color.withValues(alpha: 0.3), width: 1),
                        ),
                        child: Text(
                          widget.exp.type,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.exp.description,
              maxLines: Responsive.isMobile(context) ? 3 : 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.spaceGrotesk(
                fontSize: Responsive.isMobile(context) ? 12 : 14,
                color: AppColors.textSecondary,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.exp.achievements
                    .map(
                      (a) => SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_outline_rounded,
                                color: color, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              a,
                              maxLines: Responsive.isMobile(context) ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .map(
                      (w) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: w,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.exp.techStack
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Text(
                        t,
                        maxLines: Responsive.isMobile(context) ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: Responsive.isMobile(context) ? 10 : 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
