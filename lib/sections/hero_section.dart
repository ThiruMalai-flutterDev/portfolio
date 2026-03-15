import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_button.dart';

class HeroSection extends StatefulWidget {
  final ValueChanged<int> onScrollDown;

  const HeroSection({super.key, required this.onScrollDown});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _orbitController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      height: size.height - 70,
      constraints: const BoxConstraints(minHeight: 600),
      decoration: const BoxDecoration(color: Color(0xFF0A0A0F)),
      child: Stack(
        children: [
          // Animated background blobs
          _buildBackgroundEffects(size),

          // Grid overlay
          _buildGridOverlay(),

          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getSectionPaddingH(context),
              ),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: AppSizes.maxWidth),
                  child: isMobile || isTablet
                      ? _buildMobileContent(context)
                      : _buildDesktopContent(context),
                ),
              ),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
                child: _ScrollIndicator(onTap: () => widget.onScrollDown(3))),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundEffects(Size size) {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (_, __) {
        final t = _orbitController.value * 2 * math.pi;
        return Stack(
          children: [
            // Cyan glow top-left
            Positioned(
              top: -120 + 40 * math.sin(t * 0.5),
              left: -80 + 30 * math.cos(t * 0.3),
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.cyan.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                    stops: const [0, 1],
                  ),
                ),
              ),
            ),
            // Purple glow bottom-right
            Positioned(
              bottom: -150 + 30 * math.cos(t * 0.4),
              right: -100 + 40 * math.sin(t * 0.6),
              child: Container(
                width: 700,
                height: 700,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                    stops: const [0, 1],
                  ),
                ),
              ),
            ),
            // Small orbiting dot
            Positioned(
              top: size.height * 0.3 + 120 * math.sin(t),
              left: size.width * 0.5 + 200 * math.cos(t),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridOverlay() {
    return Positioned.fill(
      child: CustomPaint(painter: _GridPainter()),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left text
        Expanded(
          flex: 3,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: 60),
        // Right avatar card
        Expanded(
          flex: 2,
          child: _buildAvatarCard(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatarCard(context, small: true),
        const SizedBox(height: 40),
        _buildTextContent(context, centered: true),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Status badge
        _StatusBadge(),
        const SizedBox(height: 24),

        // Name
        _AnimatedGradientText(
          text: AppStrings.name,
          fontSize: Responsive.isMobile(context) ? 42 : 64,
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          AppStrings.title,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.syne(
            fontSize: Responsive.isMobile(context) ? 22 : 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),

        // Tagline
        Text(
          AppStrings.tagline,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.spaceGrotesk(
            fontSize: Responsive.isMobile(context) ? 15 : 17,
            color: const Color(0xFF6868A0),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 40),

        // Buttons
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            AnimatedGradientButton(
              label: 'View Projects',
              onTap: () => widget.onScrollDown(3),
            ),
            GlowButton(
              label: 'Contact Me',
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () => widget.onScrollDown(5),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Stats row
        _buildStatsRow(centered),
      ],
    );
  }

  Widget _buildStatsRow(bool centered) {
    final stats = [
      {'value': '4+', 'label': 'Years Exp'},
      {'value': '10+', 'label': 'Projects'},
      {'value': '2', 'label': 'Platforms'},
    ];

    return Wrap(
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      spacing: 32,
      children: stats
          .map(
            (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['value']!,
                  style: GoogleFonts.syne(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.cyan,
                  ),
                ),
                Text(
                  s['label']!,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildAvatarCard(BuildContext context, {bool small = false}) {
    return Center(
      child: Container(
        width: small ? 200 : 340,
        height: small ? 200 : 340,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage(AppAssets.profilePic),
              fit: BoxFit.cover,
              onError: (_, __) {}),
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.cyan.withValues(alpha: 0.15),
              AppColors.purple.withValues(alpha: 0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.cyan.withValues(alpha: 0.25),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withValues(alpha: 0.15),
              blurRadius: 60,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.1),
              blurRadius: 80,
              spreadRadius: 20,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!small) ...[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Flutter Dev',
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.background,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatefulWidget {
  @override
  State<_StatusBadge> createState() => _StatusBadgeState();
}

class _StatusBadgeState extends State<_StatusBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.green.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.green.withValues(alpha: 0.6 + 0.4 * _pulse.value),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.green.withValues(alpha: 0.4 * _pulse.value),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for hire',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedGradientText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _AnimatedGradientText({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFD0D0FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: GoogleFonts.syne(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -2,
          height: 1.05,
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  final VoidCallback onTap;
  const _ScrollIndicator({required this.onTap});

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _bounce,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, _bounce.value),
            child: child,
          ),
          child: Column(
            children: [
              Text(
                'Scroll Down',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  color: AppColors.textSecondary.withValues(alpha: 0.6),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 6),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.cyan,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A2E).withValues(alpha: 0.5)
      ..strokeWidth = 0.5;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
