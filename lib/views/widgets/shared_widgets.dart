import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

// ───────────────────────────────────────────────
// Color Utility Helpers
// ───────────────────────────────────────────────
Color bg(BuildContext ctx) => Theme.of(ctx).scaffoldBackgroundColor;
Color bg2(BuildContext ctx) => Theme.of(ctx).colorScheme.surface;
Color bg3(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.darkBg3
    : AppColors.lightBg3;
Color ink(BuildContext ctx) => Theme.of(ctx).colorScheme.onSurface;
Color ink2(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.darkInk2
    : AppColors.lightInk2;
Color ink3(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.darkInk3
    : AppColors.lightInk3;
Color line(BuildContext ctx) => Theme.of(ctx).dividerColor;
Color line2(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.darkLine2
    : AppColors.lightLine2;

Color accent(BuildContext ctx) => Theme.of(ctx).colorScheme.primary;
Color accentDark(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.accentDark
    : AppColors.lightAccentDark;
Color accentInk(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.accentInk
    : AppColors.lightAccentInk;
Color accentHover(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.accentHover
    : AppColors.lightAccentHover;
Color violet(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.violet
    : AppColors.lightViolet;
Color coral(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.coral
    : AppColors.lightCoral;
Color teal(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
    ? AppColors.teal
    : AppColors.lightTeal;

// ───────────────────────────────────────────────
// Scroll Animation Wrapper
// ───────────────────────────────────────────────
class ScrollAnimate extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideY;

  const ScrollAnimate({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.slideY = 0.15,
  });

  @override
  State<ScrollAnimate> createState() => _ScrollAnimateState();
}

class _ScrollAnimateState extends State<ScrollAnimate> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final key = Key(widget.child.hashCode.toString());
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.08) {
          if (mounted) {
            setState(() {
              _visible = true;
            });
          }
        }
      },
      child: widget.child
          .animate(target: _visible ? 1.0 : 0.0)
          .fadeIn(duration: widget.duration, delay: widget.delay)
          .slideY(
            begin: widget.slideY,
            end: 0,
            duration: widget.duration,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}

// ───────────────────────────────────────────────
// Responsive Navigation Bar
// ───────────────────────────────────────────────
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: bg(context).withOpacity(0.92),
        border: Border(bottom: BorderSide(color: line(context))),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 32),
        child: Row(
          children: [
            // Brand Logo
            GestureDetector(
              onTap: c.scrollToTop,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'animesh',
                    style: GoogleFonts.fraunces(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: ink(context),
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: GoogleFonts.fraunces(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: accent(context),
                    ),
                  ),
                  TextSpan(
                    text: 'dev',
                    style: GoogleFonts.fraunces(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: ink(context),
                    ),
                  ),
                ])),
              ),
            ),
            const Spacer(),
            if (!isMobile) ...[
              _NavLink('Work', () => c.scrollToSection(c.workKey)),
              const SizedBox(width: 24),
              _NavLink('Now', () => c.scrollToSection(c.nowKey)),
              const SizedBox(width: 24),
              _NavLink('Skills', () => c.scrollToSection(c.skillsKey)),
              const SizedBox(width: 24),
              _NavLink('Experience', () => c.scrollToSection(c.experienceKey)),
              const SizedBox(width: 24),
              _NavLink('Certifications', () => c.scrollToSection(c.certsKey)),
              const SizedBox(width: 24),
              _NavLink('About', () => c.scrollToSection(c.aboutKey)),
              const SizedBox(width: 24),
              _NavLink('Contact', () => c.scrollToSection(c.contactKey)),
              const SizedBox(width: 20),
            ],

            // Theme toggle
            const ThemeToggleButton(),

            const SizedBox(width: 14),

            if (!isMobile) ...[
              ResumeButton(resumeUrl: c.resumeUrl),
              const SizedBox(width: 12),
              _AccentPill('Hire me →', () => c.scrollToSection(c.contactKey)),
            ],

            // Mobile Hamburger Button
            if (isMobile) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.menu_rounded, color: ink(context), size: 26),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                tooltip: 'Open menu',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Mobile Navigation Drawer
// ───────────────────────────────────────────────
class MobileNavDrawer extends StatelessWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();

    void navigateTo(GlobalKey key) {
      Navigator.of(context).pop();
      c.scrollToSection(key);
    }

    return Drawer(
      backgroundColor: bg(context),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'animesh',
                      style: GoogleFonts.fraunces(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ink(context),
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: GoogleFonts.fraunces(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: accent(context),
                      ),
                    ),
                    TextSpan(
                      text: 'dev',
                      style: GoogleFonts.fraunces(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ink(context),
                      ),
                    ),
                  ])),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: ink(context)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _MobileNavItem(
                    icon: Icons.work_outline_rounded,
                    label: 'Selected Work',
                    onTap: () => navigateTo(c.workKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.bolt_outlined,
                    label: 'Currently Working On',
                    onTap: () => navigateTo(c.nowKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.code_rounded,
                    label: 'Skills & Tech',
                    onTap: () => navigateTo(c.skillsKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.timeline_rounded,
                    label: 'Experience Timeline',
                    onTap: () => navigateTo(c.experienceKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.card_membership_outlined,
                    label: 'Certifications',
                    onTap: () => navigateTo(c.certsKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Testimonials',
                    onTap: () => navigateTo(c.testimonialsKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.person_outline_rounded,
                    label: 'About Me',
                    onTap: () => navigateTo(c.aboutKey),
                  ),
                  _MobileNavItem(
                    icon: Icons.mail_outline_rounded,
                    label: 'Get in Touch',
                    onTap: () => navigateTo(c.contactKey),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Actions & Resume
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ResumeButton(resumeUrl: c.resumeUrl, fullWidth: true),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: c.socialLinks
                        .map((s) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: SocialIconButton(social: s),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: accent(context), size: 22),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: ink(context),
        ),
      ),
      onTap: onTap,
    );
  }
}

// ───────────────────────────────────────────────
// Theme Toggle Switch Button
// ───────────────────────────────────────────────
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    return Obx(() => GestureDetector(
          onTap: c.toggleTheme,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 52,
            height: 30,
            decoration: BoxDecoration(
              color: bg3(context),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: line2(context)),
            ),
            child: Stack(children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                top: 4,
                left: c.isDark.value ? 4 : 26,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: accent(context),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      c.isDark.value ? '☾' : '☀',
                      style: TextStyle(
                        fontSize: 10,
                        color: accentInk(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

// ───────────────────────────────────────────────
// Nav Link
// ───────────────────────────────────────────────
class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
                color: _hovered ? ink(context) : ink2(context),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: _hovered ? 32 : 0,
              decoration: BoxDecoration(
                color: accent(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Accent Pill / Hire Button
// ───────────────────────────────────────────────
class _AccentPill extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _AccentPill(this.label, this.onTap);

  @override
  State<_AccentPill> createState() => _AccentPillState();
}

class _AccentPillState extends State<_AccentPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: accent(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accentInk(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Resume Download Button
// ───────────────────────────────────────────────
class ResumeButton extends StatefulWidget {
  final String resumeUrl;
  final bool fullWidth;

  const ResumeButton({
    super.key,
    required this.resumeUrl,
    this.fullWidth = false,
  });

  @override
  State<ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<ResumeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          // TODO: Ensure widget.resumeUrl points to your actual resume link
          final uri = Uri.parse(widget.resumeUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            Get.snackbar(
              'Resume Link',
              'Please add your real resume URL in PortfolioController (resumeUrl).',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? bg3(context) : bg2(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? accent(context) : line2(context),
            ),
          ),
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,

            children: [
              Icon(Icons.download_rounded, size: 16, color: accent(context)),
              const SizedBox(width: 8),
              Text(
                'Download CV',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ink(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Social Icon Button
// ───────────────────────────────────────────────
class SocialIconButton extends StatefulWidget {
  final SocialLinkModel social;
  const SocialIconButton({super.key, required this.social});

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hovered = false;

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'github':
        return Icons.code_rounded;
      case 'linkedin':
        return Icons.work_rounded;
      case 'twitter / x':
      case 'twitter':
        return Icons.alternate_email_rounded;
      case 'email':
        return Icons.email_outlined;
      default:
        return Icons.link_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          // TODO: Make sure your social link URLs are updated in portfolio_controller.dart
          final uri = Uri.parse(widget.social.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovered ? accent(context) : bg3(context),
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered ? accent(context) : line2(context),
            ),
          ),
          child: Icon(
            _getSocialIcon(widget.social.platform),
            size: 18,
            color: _hovered ? accentInk(context) : ink(context),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Progress Bar
// ───────────────────────────────────────────────
class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    return Obx(() => Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 3,
            width: MediaQuery.of(context).size.width * c.scrollProgress.value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [violet(context), accent(context)],
              ),
            ),
          ),
        ));
  }
}

// ───────────────────────────────────────────────
// Section Header
// ───────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            color: accent(context),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 44,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ink2(context),
                ),
          ),
        ],
      ],
    );
  }
}

// ───────────────────────────────────────────────
// 3D Phone Frame
// ───────────────────────────────────────────────
class PhoneFrame extends StatefulWidget {
  final List<String> imageUrls;
  final double width;
  final double height;

  const PhoneFrame({
    super.key,
    required this.imageUrls,
    this.width = 230,
    this.height = 480,
  });

  @override
  State<PhoneFrame> createState() => _PhoneFrameState();
}

class _PhoneFrameState extends State<PhoneFrame> {
  int _currentIndex = 0;
  late final PageController _pageController;
  double _tiltX = 0;
  double _tiltY = 0;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.imageUrls.length > 1) {
      Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 2800));
        if (!mounted) return false;
        final next = (_currentIndex + 1) % widget.imageUrls.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        setState(() => _currentIndex = next);
        return true;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent e, BoxConstraints constraints) {
    final x = e.localPosition.dx / constraints.maxWidth - 0.2;
    final y = e.localPosition.dy / constraints.maxHeight - 0.2;
    setState(() {
      _tiltY = x * 24;
      _tiltX = -y * 24;
      _hovering = true;
    });
  }

  void _onExit(PointerEvent e) {
    setState(() {
      _tiltX = 0;
      _tiltY = 0;
      _hovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (e) => _onHover(e, constraints),
          onExit: _onExit,
          child: GestureDetector(
            onPanUpdate: (d) {
              setState(() {
                _tiltY += d.delta.dx * 0.5;
                _tiltX -= d.delta.dy * 0.5;
                _tiltY = _tiltY.clamp(-20.0, 20.0);
                _tiltX = _tiltX.clamp(-20.0, 20.0);
              });
            },
            onPanEnd: (_) => setState(() {
              _tiltX = 0;
              _tiltY = 0;
            }),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_tiltX * 3.14159 / 180)
                ..rotateY(_tiltY * 3.14159 / 180),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBg3 : AppColors.lightBg3,
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.black.withOpacity(0.08),
                    width: 1,
                  ),
                  boxShadow: isDark
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 60,
                            spreadRadius: -10,
                            offset: Offset(_tiltY * 0.8, 30 + _tiltX * 0.5),
                          ),
                          BoxShadow(
                            color: AppColors.violet.withOpacity(0.18),
                            blurRadius: 80,
                            spreadRadius: -20,
                            offset: Offset(_tiltY * 0.3, 10),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.14),
                            blurRadius: 50,
                            spreadRadius: -8,
                            offset: Offset(_tiltY * 0.6, 24 + _tiltX * 0.4),
                          ),
                        ],
                ),
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.imageUrls.length,
                        itemBuilder: (_, i) => Image.network(
                          widget.imageUrls[i],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: isDark ? AppColors.darkBg3 : AppColors.lightBg3,
                            child: Center(
                              child: Icon(Icons.smartphone_rounded,
                                  color: ink3(context), size: 40),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(
                                (-_tiltY / 20).clamp(-1.0, 1.0),
                                (_tiltX / 20).clamp(-1.0, 1.0),
                              ),
                              end: Alignment(
                                (_tiltY / 20).clamp(-1.0, 1.0),
                                (-_tiltX / 20).clamp(-1.0, 1.0),
                              ),
                              colors: [
                                Colors.white.withOpacity(_hovering ? 0.12 : 0.0),
                                Colors.transparent,
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 22,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkBg : AppColors.lightBg,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.imageUrls.length > 1)
                        Positioned(
                          bottom: 14,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.imageUrls.length,
                              (i) {
                                final active = i == _currentIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: active ? 14 : 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: active
                                        ? accent(context)
                                        : Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ───────────────────────────────────────────────
// Skill Bar Card
// ───────────────────────────────────────────────
class SkillBarCard extends StatefulWidget {
  final SkillModel skill;
  const SkillBarCard({super.key, required this.skill});

  @override
  State<SkillBarCard> createState() => _SkillBarCardState();
}

class _SkillBarCardState extends State<SkillBarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _anim = Tween<double>(begin: 0, end: widget.skill.percentage / 100)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    final portfolioCtrl = Get.find<PortfolioController>();
    portfolioCtrl.scrollController.addListener(_tryAnimate);
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryAnimate());
  }

  void _tryAnimate() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(context).size.height;
    if (pos.dy < screenH * 0.92) {
      _triggered = true;
      _ctrl.forward();
    }
  }

  @override
  void dispose() {
    final portfolioCtrl = Get.find<PortfolioController>();
    portfolioCtrl.scrollController.removeListener(_tryAnimate);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg2(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: line2(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.skill.name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ink(context),
                ),
              ),
              AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => Text(
                  '${(_anim.value * 100).round()}%',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: bg3(context),
              borderRadius: BorderRadius.circular(4),
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => FractionallySizedBox(
                widthFactor: _anim.value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: accent(context),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Education Row
// ───────────────────────────────────────────────
class EduRow extends StatelessWidget {
  final EducationModel edu;
  const EduRow({super.key, required this.edu});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: line(context))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.degree,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ink(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${edu.institute} · ${edu.year}',
                  style: GoogleFonts.inter(fontSize: 13, color: ink3(context)),
                ),
              ],
            ),
          ),
          Text(
            edu.score,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accent(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Stack Pill
// ───────────────────────────────────────────────
class StackPill extends StatelessWidget {
  final String label;
  const StackPill(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg3(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent(context).withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: accent(context),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// App Link Card (Live Play Store / GitHub)
// ───────────────────────────────────────────────
class AppLinkCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? url;
  final IconData icon;

  const AppLinkCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.url,
    this.icon = Icons.shop_rounded,
  });

  @override
  State<AppLinkCard> createState() => _AppLinkCardState();
}

class _AppLinkCardState extends State<AppLinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hasUrl = widget.url != null && widget.url!.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: hasUrl ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () async {
          if (hasUrl) {
            final uri = Uri.parse(widget.url!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered && hasUrl ? -3 : 0, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg3(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered && hasUrl
                  ? accent(context).withOpacity(0.4)
                  : line2(context),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: accentInk(context), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ink(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ink3(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (hasUrl) ...[
                const SizedBox(width: 8),
                Text(
                  '→',
                  style: TextStyle(fontSize: 18, color: accent(context)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Back To Top Button
// ───────────────────────────────────────────────
class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    return Obx(() => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: c.showBackToTop.value ? 1 : 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset: c.showBackToTop.value ? Offset.zero : const Offset(0, 0.5),
            child: FloatingActionButton(
              onPressed: c.scrollToTop,
              backgroundColor: accent(context),
              foregroundColor: accentInk(context),
              mini: true,
              child: const Text('↑', style: TextStyle(fontSize: 18)),
            ),
          ),
        ));
  }
}
