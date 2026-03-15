import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

class AnimatedGradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool compact;
  final bool fullWidth;
  final bool outlined;

  const AnimatedGradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.compact = false,
    this.fullWidth = false,
    this.outlined = false,
  });

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.fullWidth ? double.infinity : null,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 18 : 28,
              vertical: widget.compact ? 10 : 16,
            ),
            decoration: BoxDecoration(
              gradient: widget.outlined
                  ? null
                  : LinearGradient(
                      colors: _hovered
                          ? [AppColors.purple, AppColors.cyan]
                          : [AppColors.cyan, AppColors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
              borderRadius: BorderRadius.circular(widget.compact ? 8 : 12),
              border: widget.outlined
                  ? Border.all(
                      color: _hovered ? AppColors.cyan : AppColors.border,
                      width: 1.5,
                    )
                  : null,
              boxShadow: !widget.outlined
                  ? [
                      BoxShadow(
                        color: AppColors.cyan.withValues(alpha: _hovered ? 0.3 : 0.15),
                        blurRadius: _hovered ? 20 : 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize:
                  widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: widget.compact ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: widget.outlined
                        ? (_hovered ? AppColors.cyan : AppColors.textSecondary)
                        : Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlowButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final Color color;

  const GlowButton({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
    this.color = AppColors.cyan,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
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
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.color
                  : widget.color.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: widget.color, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
