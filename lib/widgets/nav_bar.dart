import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import 'animated_button.dart';

class NavBar extends StatelessWidget {
  final int activeIndex;
  final bool isScrolled;
  final Function(int) onNavTap;

  const NavBar({
    super.key,
    required this.activeIndex,
    required this.isScrolled,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppSizes.navHeight,
      decoration: BoxDecoration(
        color: isScrolled
            ? const Color(0xFF0A0A0F).withValues(alpha: 0.95)
            : Colors.transparent,
        border: isScrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.6),
                  width: 1,
                ),
              )
            : null,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.getSectionPaddingH(context),
        ),
        child: Row(
          children: [
            // Logo
            _buildLogo(context),

            const Spacer(),

            // Nav items (desktop)
            if (!isMobile) ...[
              ..._buildNavItems(context),
              const SizedBox(width: 24),
              _buildHireMeButton(context),
            ] else
              _buildMobileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavTap(0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.cyan, AppColors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'TS',
                  style: GoogleFonts.syne(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Thiru.dev',
              style: GoogleFonts.syne(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    return AppStrings.navItems.asMap().entries.map((entry) {
      final i = entry.key;
      final label = entry.value;
      final isActive = activeIndex == i + 1;

      return Padding(
        padding: const EdgeInsets.only(right: 4),
        child: _NavItem(
          label: label,
          isActive: isActive,
          onTap: () => onNavTap(i + 1),
        ),
      );
    }).toList();
  }

  Widget _buildHireMeButton(BuildContext context) {
    return AnimatedGradientButton(
      label: "Hire Me",
      onTap: () => onNavTap(5),
      compact: true,
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return Builder(
      builder: (ctx) => IconButton(
        icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
        onPressed: () => _showMobileDrawer(context),
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111118),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MobileDrawer(
        activeIndex: activeIndex,
        onNavTap: (i) {
          Navigator.pop(context);
          onNavTap(i);
        },
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered || widget.isActive
                ? AppColors.cyan.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isActive
                  ? AppColors.cyan.withValues(alpha: 0.4)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
              color: widget.isActive || _hovered
                  ? AppColors.cyan
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final int activeIndex;
  final Function(int) onNavTap;

  const _MobileDrawer({
    required this.activeIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          ...AppStrings.navItems.asMap().entries.map((entry) {
            final i = entry.key;
            final label = entry.value;
            return ListTile(
              title: Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  color: activeIndex == i + 1
                      ? AppColors.cyan
                      : AppColors.textSecondary,
                  fontWeight:
                      activeIndex == i + 1 ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              trailing: activeIndex == i + 1
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.cyan,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
              onTap: () => onNavTap(i + 1),
            );
          }),
          const SizedBox(height: 16),
          AnimatedGradientButton(
            label: 'Hire Me',
            onTap: () => onNavTap(5),
            fullWidth: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
