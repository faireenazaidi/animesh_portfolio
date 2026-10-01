import 'dart:ui';
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
Color bg3(BuildContext ctx) => AppColors.darkBg3;
Color ink(BuildContext ctx) => Theme.of(ctx).colorScheme.onSurface;
Color ink2(BuildContext ctx) => AppColors.darkInk2;
Color ink3(BuildContext ctx) => AppColors.darkInk3;
Color line(BuildContext ctx) => Theme.of(ctx).dividerColor;
Color line2(BuildContext ctx) => AppColors.darkLine2;

Color accent(BuildContext ctx) => Theme.of(ctx).colorScheme.primary;
Color accentDark(BuildContext ctx) => AppColors.accentDark;
Color accentInk(BuildContext ctx) => AppColors.accentInk;
Color accentHover(BuildContext ctx) => AppColors.accentHover;
Color violet(BuildContext ctx) => AppColors.violet;
Color coral(BuildContext ctx) => AppColors.coral;
Color teal(BuildContext ctx) => AppColors.teal;
Color pink(BuildContext ctx) => AppColors.pink;
Color amber(BuildContext ctx) => AppColors.amber;

// ───────────────────────────────────────────────
// Glassmorphism Card Container
// ───────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final double blur;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.borderColor,
    this.borderWidth = 1,
    this.blur = 16,
    this.backgroundColor,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBg = bg2(context).withOpacity(0.45);
    final defaultBorder = line2(context).withOpacity(0.35);

    Widget result = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? defaultBg,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? defaultBorder,
                width: borderWidth,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.01),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: result);
    }
    return result;
  }
}

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

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: bg(context).withOpacity(0.70),
            border: Border(bottom: BorderSide(color: line2(context).withOpacity(0.3))),
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

                const SizedBox(width: 8),

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
// Theme Toggle (Deprecated - Dark Theme Exclusive)
// ───────────────────────────────────────────────
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
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
          String rawUrl = widget.resumeUrl.trim();
          if (rawUrl.isEmpty) {
            Get.snackbar(
              'Resume Link Missing',
              'Please specify a valid resume URL in PortfolioController.',
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          // Automatically convert GitHub web blob link to direct raw file link
          if (rawUrl.contains('github.com') && rawUrl.contains('/blob/')) {
            rawUrl = rawUrl.replaceFirst('/blob/', '/raw/');
          }

          final uri = Uri.parse(rawUrl);
          try {
            final launched = await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            if (!launched) {
              await launchUrl(uri);
            }
          } catch (e) {
            try {
              await launchUrl(uri);
            } catch (_) {
              Get.snackbar(
                'Resume Download',
                'Unable to open resume link. Please check link validity.',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
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
          child: Container(
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
// Realistic Smartphone Frame Mockup
// ───────────────────────────────────────────────
class PhoneFrame extends StatefulWidget {
  final List<String> imageUrls;
  final double width;
  final double height;

  const PhoneFrame({
    super.key,
    required this.imageUrls,
    this.width = 220,
    this.height = 460,
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
        await Future.delayed(const Duration(milliseconds: 3200));
        if (!mounted) return false;
        final next = (_currentIndex + 1) % widget.imageUrls.length;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
          );
        }
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
    final x = (e.localPosition.dx / constraints.maxWidth) - 0.5;
    final y = (e.localPosition.dy / constraints.maxHeight) - 0.5;
    setState(() {
      _tiltY = x * 14;
      _tiltX = -y * 14;
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

    // Physical chassis colors
    final frameBorderColor = isDark ? const Color(0xFF383B40) : const Color(0xFFB0B4BC);
    const innerBezelColor = Color(0xFF0C0D0E);
    final buttonColor = isDark ? const Color(0xFF2C2E33) : const Color(0xFF9EABB5);

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (e) => _onHover(e, constraints),
          onExit: _onExit,
          child: GestureDetector(
            onPanUpdate: (d) {
              setState(() {
                _tiltY += d.delta.dx * 0.4;
                _tiltX -= d.delta.dy * 0.4;
                _tiltY = _tiltY.clamp(-16.0, 16.0);
                _tiltX = _tiltX.clamp(-16.0, 16.0);
              });
            },
            onPanEnd: (_) => setState(() {
              _tiltX = 0;
              _tiltY = 0;
            }),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0008)
                ..rotateX(_tiltX * 3.14159 / 180)
                ..rotateY(_tiltY * 3.14159 / 180),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // ── Physical Side Buttons ──
                    // Left Action Button
                    Positioned(
                      left: -2.5,
                      top: widget.height * 0.18,
                      child: Container(
                        width: 2.5,
                        height: 16,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
                        ),
                      ),
                    ),
                    // Left Volume Up Button
                    Positioned(
                      left: -2.5,
                      top: widget.height * 0.25,
                      child: Container(
                        width: 2.5,
                        height: 32,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
                        ),
                      ),
                    ),
                    // Left Volume Down Button
                    Positioned(
                      left: -2.5,
                      top: widget.height * 0.35,
                      child: Container(
                        width: 2.5,
                        height: 32,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
                        ),
                      ),
                    ),
                    // Right Power Button
                    Positioned(
                      right: -2.5,
                      top: widget.height * 0.27,
                      child: Container(
                        width: 2.5,
                        height: 48,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
                        ),
                      ),
                    ),

                    // ── Phone Outer Chassis Frame ──
                    Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: innerBezelColor,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: frameBorderColor,
                          width: 2.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(7), // Realistic uniform bezel thickness
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(33),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Screen Wallpaper / App Screens
                            PageView.builder(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.imageUrls.length,
                              itemBuilder: (_, i) => Image.network(
                                widget.imageUrls[i],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFF14171A),
                                  child: Center(
                                    child: Icon(
                                      Icons.smartphone_rounded,
                                      color: ink3(context),
                                      size: 38,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Realistic Diagonal Glass Sheen / Specular Glare
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(
                                        (-0.8 + (-_tiltY / 15)).clamp(-1.0, 1.0),
                                        (-1.0 + (_tiltX / 15)).clamp(-1.0, 1.0),
                                      ),
                                      end: Alignment(
                                        (0.8 + (_tiltY / 15)).clamp(-1.0, 1.0),
                                        (1.0 + (-_tiltX / 15)).clamp(-1.0, 1.0),
                                      ),
                                      colors: [
                                        Colors.white.withValues(alpha: _hovering ? 0.12 : 0.05),
                                        Colors.white.withValues(alpha: 0.0),
                                        Colors.white.withValues(alpha: _hovering ? 0.04 : 0.01),
                                      ],
                                      stops: const [0.0, 0.45, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // ── Top Status Bar & Dynamic Island ──
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 36,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Status Bar Left: Clock Time
                                    Positioned(
                                      left: 4,
                                      top: 8,
                                      child: Text(
                                        '9:41',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white.withValues(alpha: 0.95),
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                    ),

                                    // Top Dynamic Island Pill
                                    Positioned(
                                      top: 6,
                                      child: Container(
                                        width: 68,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.white.withValues(alpha: 0.08),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(width: 8),
                                            // Tiny Camera Lens reflection
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF0F1A29),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: 2.5,
                                                  height: 2.5,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFF1E3A5F),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            // FaceID Sensor dot
                                            Container(
                                              width: 3.5,
                                              height: 3.5,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withValues(alpha: 0.15),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Status Bar Right: Signal, Wifi, Battery
                                    Positioned(
                                      right: 4,
                                      top: 9,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Cellular signal bars
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              _signalBar(3),
                                              const SizedBox(width: 1.5),
                                              _signalBar(4.5),
                                              const SizedBox(width: 1.5),
                                              _signalBar(6),
                                              const SizedBox(width: 1.5),
                                              _signalBar(7.5),
                                            ],
                                          ),
                                          const SizedBox(width: 4),
                                          // WiFi Icon
                                          const Icon(
                                            Icons.wifi_rounded,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          // Battery Icon
                                          Container(
                                            width: 15,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2.5),
                                              border: Border.all(
                                                color: Colors.white.withValues(alpha: 0.9),
                                                width: 0.9,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(1),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: 8.5,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ── Bottom Home Bar Indicator ──
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 68,
                                  height: 3.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),

                            // ── Slide Indicator Dots (Floating pill) ──
                            if (widget.imageUrls.length > 1)
                              Positioned(
                                bottom: 18,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        widget.imageUrls.length,
                                        (i) {
                                          final active = i == _currentIndex;
                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                            width: active ? 12 : 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: active
                                                  ? Colors.white
                                                  : Colors.white.withValues(alpha: 0.35),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _signalBar(double height) {
    return Container(
      width: 2,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.5),
      ),
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
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 16,
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
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: 16,
          borderColor: _hovered && hasUrl
              ? accent(context).withOpacity(0.5)
              : line2(context).withOpacity(0.35),
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

// ───────────────────────────────────────────────
// Ambient Glow & Tech Dot Grid Background Overlay
// ───────────────────────────────────────────────
class BackgroundGlowAndGrid extends StatelessWidget {
  const BackgroundGlowAndGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryAccent = accent(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return RepaintBoundary(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: IgnorePointer(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Top Right Ambient Glow Spot
              Positioned(
                top: -80,
                right: -60,
                child: Container(
                  width: isMobile ? 300 : 540,
                  height: isMobile ? 300 : 540,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        primaryAccent.withOpacity(isDark ? 0.12 : 0.05),
                        primaryAccent.withOpacity(isDark ? 0.03 : 0.01),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Middle Left Ambient Glow Spot
              Positioned(
                top: 400,
                left: -120,
                child: Container(
                  width: isMobile ? 240 : 480,
                  height: isMobile ? 240 : 480,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        primaryAccent.withOpacity(isDark ? 0.08 : 0.03),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              // Custom Hardware-Accelerated Dot Grid Painter
              CustomPaint(
                size: Size(size.width, size.height),
                painter: _DotGridPainter(
                  color: line(context).withOpacity(isDark ? 0.35 : 0.20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final Color color;
  const _DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final List<Offset> points = [];
    const spacing = 36.0;
    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        points.add(Offset(x, y));
      }
    }
    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => oldDelegate.color != color;
}
