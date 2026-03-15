import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  bool _showFloatingNav = false;
  int _activeSection = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 100 && !_showFloatingNav) {
      setState(() => _showFloatingNav = true);
    } else if (offset <= 100 && _showFloatingNav) {
      setState(() => _showFloatingNav = false);
    }

    // Detect active section
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          if (pos.dy <= MediaQuery.of(context).size.height * 0.4) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void scrollToSection(int index) {
    final key = _sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Spacer for navbar
                const SizedBox(height: 70),

                // Sections
                KeyedSection(
                  sectionKey: _sectionKeys[0],
                  child: HeroSection(
                      onScrollDown: (index) => scrollToSection(index)),
                ),
                KeyedSection(
                  sectionKey: _sectionKeys[1],
                  child: const AboutSection(),
                ),
                KeyedSection(
                  sectionKey: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
                KeyedSection(
                  sectionKey: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
                KeyedSection(
                  sectionKey: _sectionKeys[4],
                  child: const ExperienceSection(),
                ),
                KeyedSection(
                  sectionKey: _sectionKeys[5],
                  child: const ContactSection(),
                ),
                const Footer(),
              ],
            ),
          ),

          // Floating NavBar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              activeIndex: _activeSection,
              isScrolled: _showFloatingNav,
              onNavTap: scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}

class KeyedSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;

  const KeyedSection({
    super.key,
    required this.sectionKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: sectionKey, child: child);
  }
}
