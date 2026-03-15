import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionTitle({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Tag label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            tag.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: AppColors.cyan,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          title,
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
          style: GoogleFonts.syne(
            fontSize: Responsive.isMobile(context) ? 28 : 40,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),

        // Accent line
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.cyan, AppColors.purple],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.left,
              style: GoogleFonts.spaceGrotesk(
                fontSize: Responsive.isMobile(context) ? 15 : 17,
                color: AppColors.textSecondary,
                height: 1.7,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class FadeInSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset slideFrom;

  const FadeInSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideFrom = const Offset(0, 30),
  });

  @override
  State<FadeInSection> createState() => _FadeInSectionState();
}

class _FadeInSectionState extends State<FadeInSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: widget.slideFrom,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: _slide.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
