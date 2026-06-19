import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';


Color bg(BuildContext ctx) => Theme.of(ctx).scaffoldBackgroundColor;
Color bg2(BuildContext ctx) => Theme.of(ctx).colorScheme.surface;
Color bg3(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark ? AppColors.darkBg3 : AppColors.lightBg3;
Color ink(BuildContext ctx) => Theme.of(ctx).colorScheme.onSurface;
Color ink2(BuildContext ctx) =>Theme.of(ctx).brightness == Brightness.dark ? AppColors.darkInk2 : AppColors.lightInk2;
Color ink3(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark ? AppColors.darkInk3 : AppColors.lightInk3;
Color line(BuildContext ctx) => Theme.of(ctx).dividerColor;
Color line2(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark ? AppColors.darkLine2 : AppColors.lightLine2;


class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: bg(context).withOpacity(0.85),
        border: Border(bottom: BorderSide(color: line(context))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            // Brand
            Text.rich(TextSpan(children: [
              TextSpan(
                text: 'animesh',
                style: GoogleFonts.fraunces(
                  fontSize: 20, fontWeight: FontWeight.w500, color: ink(context)),
              ),
              TextSpan(
                text: '.',
                style: GoogleFonts.fraunces(
                  fontSize: 25, fontWeight: FontWeight.w500,
                  color: AppColors.accent),
              ),
              TextSpan(
                text: 'dev',
                style: GoogleFonts.fraunces(
                  fontSize: 20, fontWeight: FontWeight.w500, color: ink(context)),
              ),
            ])),
            const Spacer(),
            if (!isMobile) ...[
              _NavLink('Work', () => c.scrollToSection(c.workKey)),
              const SizedBox(width: 32),
              _NavLink('Skills', () => c.scrollToSection(c.skillsKey)),
              const SizedBox(width: 32),
              _NavLink('About', () => c.scrollToSection(c.aboutKey)),
              const SizedBox(width: 32),
              _NavLink('Contact', () => c.scrollToSection(c.contactKey)),
              const SizedBox(width: 24),
            ],
            // Theme toggle
            Obx(() => GestureDetector(
              onTap: c.toggleTheme,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 50, height: 28,
                decoration: BoxDecoration(
                  color: bg3(context),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: line2(context)),
                ),
                child: Stack(children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    top: 3,
                    left: c.isDark.value ? 3 : 25,
                    child: Container(
                      width: 20, height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          c.isDark.value ? '☾' : '☀',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )),
            const SizedBox(width: 14),
            if (!isMobile)
              _AccentPill('Hire me →', () => c.scrollToSection(c.contactKey)),
          ],
        ),
      ),
    );
  }
}

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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: _hovered ? ink(context) : ink2(context),
              )),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 1,
              width: _hovered ? 40 : 0,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

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
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(widget.label,
              style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w600,
                color: AppColors.accentInk,
              )),
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
        height: 2,
        width: MediaQuery.of(context).size.width * c.scrollProgress.value,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.violet, AppColors.accent],
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
        Text(eyebrow,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11, letterSpacing: 1.0,
            color: AppColors.accent,
          )),
        const SizedBox(height: 14),
        Text(title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 44,
          )),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          Text(subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ink2(context),
            )),
        ],
      ],
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2, end: 0);
  }
}

// ───────────────────────────────────────────────
// Phone Frame
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

  // 3D tilt values
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
      _tiltY = x * 24;   // left-right tilt degrees
      _tiltX = -y * 24;  // up-down tilt degrees
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
            // Touch support for mobile
            onPanUpdate: (d) {
              setState(() {
                _tiltY += d.delta.dx * 0.5;
                _tiltX -= d.delta.dy * 0.5;
                _tiltY = _tiltY.clamp(-20.0, 20.0);
                _tiltX = _tiltX.clamp(-20.0, 20.0);
              });
            },
            onPanEnd: (_) => setState(() { _tiltX = 0; _tiltY = 0; }),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration.zero,
              builder: (_, __, child) => child!,
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
                    color: isDark ? AppColors.darkBg3 : const Color(0xFFE8E8E2),
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
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.06),
                        blurRadius: 40,
                        offset: Offset(-_tiltY * 0.5, -10),
                      ),
                    ]
                        : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.14),
                        blurRadius: 50,
                        spreadRadius: -8,
                        offset: Offset(_tiltY * 0.6, 24 + _tiltX * 0.4),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        spreadRadius: -4,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        // Images
                        PageView.builder(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.imageUrls.length,
                          itemBuilder: (_, i) => Image.network(
                            widget.imageUrls[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: isDark
                                  ? AppColors.darkBg3
                                  : AppColors.lightBg3,
                            ),
                          ),
                        ),
                        // Glare overlay that moves with tilt
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
                                  Colors.white.withOpacity(
                                      _hovering ? 0.12 : 0.0),
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Notch
                        Positioned(
                          top: 0, left: 0, right: 0,
                          child: Center(
                            child: Container(
                              width: 80, height: 22,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkBg
                                    : AppColors.lightBg,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Dots
                        if (widget.imageUrls.length > 1)
                          Positioned(
                            bottom: 14, left: 0, right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.imageUrls.length,
                                    (i) {
                                  final active = i == _currentIndex;
                                  return AnimatedContainer(
                                    duration:
                                    const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    width: active ? 14 : 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: active
                                          ? AppColors.accent
                                          : Colors.white.withOpacity(0.3),
                                      borderRadius:
                                      BorderRadius.circular(3),
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
          ),
        );
      },
    );
  }
}

// ───────────────────────────────────────────────
// Skill Bar
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
      duration: const Duration(milliseconds: 2000),
    );
    _anim = Tween<double>(begin: 0, end: widget.skill.percentage / 100)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    // Listen to the scroll controller from the portfolio controller
    final portfolioCtrl = Get.find<PortfolioController>();
    portfolioCtrl.scrollController.addListener(() => _tryAnimate());

    // Also check once after first frame in case already visible
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
    // Remove listener when widget is disposed
    final portfolioCtrl = Get.find<PortfolioController>();
    portfolioCtrl.scrollController.removeListener(() => _tryAnimate());
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
                Text(widget.skill.name,
                    style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w500,
                      color: ink(context),
                    )),
                AnimatedBuilder(
                  animation: _anim,
                  builder: (_, __) => Text(
                    '${(_anim.value * 100).round()}%',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12, color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 4,
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
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                Text(edu.degree,
                  style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w500, color: ink(context),
                  )),
                const SizedBox(height: 3),
                Text('${edu.institute} · ${edu.year}',
                  style: GoogleFonts.inter(fontSize: 13, color: ink3(context))),
              ],
            ),
          ),
          Text(edu.score,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12, color: AppColors.accent,
            )),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Pill / Stack chip
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
        border: Border.all(color: AppColors.accent.withOpacity(0.18)),
      ),
      child: Text(label,
        style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppColors.accent)),
    );
  }
}

// ───────────────────────────────────────────────
// App Link card
// ───────────────────────────────────────────────
class AppLinkCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? url;
  const AppLinkCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.url,
  });

  @override
  State<AppLinkCard> createState() => _AppLinkCardState();
}

class _AppLinkCardState extends State<AppLinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final u = widget.url;
          if (u != null && u.isNotEmpty) {
            await launchUrl(Uri.parse(u));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg3(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.3)
                  : line2(context),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.layers_rounded,
                  color: AppColors.accentInk, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w600,
                        color: ink(context),
                      )),
                    const SizedBox(height: 2),
                    Text(widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12, color: ink3(context),
                      ),
                      overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('→',
                style: TextStyle(
                  fontSize: 18, color: AppColors.accent,
                )),
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
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.accentInk,
          mini: true,
          child: const Text('↑', style: TextStyle(fontSize: 18)),
        ),
      ),
    ));
  }
}

// ───────────────────────────────────────────────
// Visibility Detector wrapper (simple)
// ───────────────────────────────────────────────
class VisibilityDetectorWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onVisible;
  const VisibilityDetectorWrapper({
    super.key,
    required this.child,
    required this.onVisible,
  });

  @override
  State<VisibilityDetectorWrapper> createState() =>
      _VisibilityDetectorWrapperState();
}

class _VisibilityDetectorWrapperState
    extends State<VisibilityDetectorWrapper> {
  bool _triggered = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: Builder(
        builder: (ctx) {
          if (!_triggered) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkVisibility(ctx);
            });
          }
          return widget.child;
        },
      ),
    );
  }

  void _checkVisibility(BuildContext ctx) {
    if (_triggered) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(ctx).size.height;
    if (pos.dy < screenH * 1.1) {
      _triggered = true;
      widget.onVisible();
    }
  }
}
