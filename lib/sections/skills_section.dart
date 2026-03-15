import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../models/skill_model.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.getSectionPaddingH(context);
    final padV = Responsive.getSectionPaddingV(context);
    final isMobile = Responsive.isMobile(context);

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
              FadeInSection(
                child: const SectionTitle(
                  tag: 'Skills',
                  title: 'Tech Stack',
                  subtitle:
                      'Technologies I use to build robust, scalable Flutter applications.',
                ),
              ),
              const SizedBox(height: 60),

              // Category filter tabs
              FadeInSection(
                delay: const Duration(milliseconds: 150),
                child: _SkillGrid(isMobile: isMobile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillGrid extends StatefulWidget {
  final bool isMobile;
  const _SkillGrid({required this.isMobile});

  @override
  State<_SkillGrid> createState() => _SkillGridState();
}

class _SkillGridState extends State<_SkillGrid> {
  String _activeCategory = 'All';

  final List<String> _categories = [
    'All',
    'Core',
    'State',
    'Backend',
    'Tools',
    'Platform',
    'Design',
  ];

  List<SkillModel> get _filteredSkills {
    if (_activeCategory == 'All') return skills;
    return skills.where((s) => s.category == _activeCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((cat) {
              final isActive = _activeCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _CategoryTab(
                  label: cat,
                  isActive: isActive,
                  onTap: () => setState(() => _activeCategory = cat),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 40),

        // Skills grid
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildGrid(context),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    final crossAxisCount = widget.isMobile ? 2 : Responsive.isTablet(context) ? 3 : 4;
    final filtered = _filteredSkills;

    return GridView.builder(
      key: ValueKey(_activeCategory),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, i) => _SkillCard(
        skill: filtered[i],
        delay: Duration(milliseconds: i * 60),
      ),
    );
  }
}

class _CategoryTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<_CategoryTab> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.cyan.withValues(alpha: 0.15)
                : _hovered
                    ? AppColors.surfaceElevated
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isActive
                  ? AppColors.cyan.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.w400,
              color: widget.isActive
                  ? AppColors.cyan
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  final Duration delay;

  const _SkillCard({required this.skill, required this.delay});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.skill.color;

    return FadeTransition(
      opacity: _fadeAnim,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.surfaceElevated
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? color.withValues(alpha: 0.4)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.skill.icon,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.skill.category,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: color,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.skill.name,
                    style: GoogleFonts.syne(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Proficiency bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: widget.skill.proficiency / 10,
                      backgroundColor: color.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation(color),
                      minHeight: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
