import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../models/project_model.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.getSectionPaddingH(context);
    final padV = Responsive.getSectionPaddingV(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInSection(
                child: const SectionTitle(
                  tag: 'Projects',
                  title: 'Featured Work',
                  subtitle:
                      'A selection of projects I\'ve built — from diagnostic apps to e-commerce solutions.',
                ),
              ),
              const SizedBox(height: 60),
              ...projects.asMap().entries.map((entry) {
                final i = entry.key;
                final project = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: FadeInSection(
                    delay: Duration(milliseconds: i * 150),
                    child: _ProjectCard(
                      project: project,
                      isReversed: i % 2 == 1 && !Responsive.isMobile(context),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isReversed;

  const _ProjectCard({required this.project, this.isReversed = false});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(widget.project.accentColor));
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? color.withValues(alpha: 0.4) : AppColors.border,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  )
                ]
              : null,
        ),
        child: isMobile
            ? _buildMobileCard(context, color)
            : _buildDesktopCard(context, color),
      ),
    );
  }

  Widget _buildDesktopCard(BuildContext context, Color color) {
    final children = [
      Expanded(child: _buildProjectVisual(color)),
      Expanded(
        flex: 2,
        child: _buildProjectInfo(context, color),
      ),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.isReversed ? children.reversed.toList() : children,
      ),
    );
  }

  Widget _buildMobileCard(BuildContext context, Color color) {
    return Column(
      children: [
        _buildProjectVisual(color, height: 180),
        _buildProjectInfo(context, color),
      ],
    );
  }

  Widget _buildProjectVisual(Color color, {double? height}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: widget.isReversed
            ? const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Project number
          Text(
            widget.project.id,
            style: GoogleFonts.syne(
              fontSize: 72,
              fontWeight: FontWeight.w900,
              color: color.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(height: 12),
          // Phone mock icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Icon(Icons.phone_android_rounded, color: color, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context, Color color) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Text(
              widget.project.category.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            widget.project.title,
            style: GoogleFonts.syne(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.project.subtitle,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            widget.project.description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: const Color(0xFF7777A0),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),

          // Responsibilities
          Text(
            'Key Contributions',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          ...widget.project.responsibilities.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      r,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tech chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.techStack
                .map((t) => _TechChip(label: t, color: color))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TechChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
