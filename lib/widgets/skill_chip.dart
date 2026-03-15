import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final Color color;
  final String? icon;
  final bool compact;

  const SkillChip({
    super.key,
    required this.label,
    this.color = AppColors.cyan,
    this.icon,
    this.compact = false,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 10 : 14,
          vertical: widget.compact ? 5 : 8,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withValues(alpha: 0.12)
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.5)
                : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Text(
                widget.icon!,
                style: TextStyle(fontSize: widget.compact ? 12 : 14),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              widget.label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: widget.compact ? 12 : 13,
                fontWeight: FontWeight.w500,
                color: _hovered ? widget.color : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
