import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/video_avatar_widget.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      key: c.heroKey,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: isMobile ? 100 : 140,
        bottom: 80,
        left: isMobile ? 20 : 32,
        right: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: isDesktop
              ? _DesktopHero(c: c)
              : _MobileHero(c: c),
        ),
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final PortfolioController c;
  const _DesktopHero({required this.c});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 11, child: _HeroContent(c: c)),
        const SizedBox(width: 40),
        Expanded(
          flex: 9,
          child: Center(
            child: const _RealAvatarWidget(isMobile: false),
          ),
        ),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final PortfolioController c;
  const _MobileHero({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroContent(c: c),
        const SizedBox(height: 48),
        Center(
          child: const _RealAvatarWidget(isMobile: true),
        ),
      ],
    );
  }
}

class _RealAvatarWidget extends StatefulWidget {
  final bool isMobile;
  const _RealAvatarWidget({required this.isMobile});

  @override
  State<_RealAvatarWidget> createState() => _RealAvatarWidgetState();
}

class _RealAvatarWidgetState extends State<_RealAvatarWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.isMobile ? 320.0 : 440.0;
    final height = widget.isMobile ? 420.0 : 520.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: width,
        height: height,
        transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Background Ambient Glow Aura (Soft light behind avatar)
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: width * 0.9,
              height: height * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accent(context).withValues(alpha: _isHovered ? 0.35 : 0.22),
                    accent(context).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Video Avatar Player (Without rectangular video background / border)
            SizedBox(
              width: width * 0.9,
              height: height * 0.92,
              child: UniversalVideoAvatar(
                width: width * 0.9,
                height: height * 0.92,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(
                  begin: 0.08,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),

            // Bottom Floating Badge
            Positioned(
              bottom: 12,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: bg3(context).withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: line2(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    ).scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2),
                      duration: 1000.ms,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Android & Flutter Engineer',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ink(context),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: widget.isMobile ? -8 : 0,
              left: widget.isMobile ? 8 : 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: BoxDecoration(
                  color: bg2(context),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                    bottomLeft: Radius.circular(4),
                  ),
                  border: Border.all(
                    color: accent(context).withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent(context).withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // child: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     // Waving Hand Animation 👋
                //     Text(
                //       '👋',
                //       style: TextStyle(
                //         fontSize: widget.isMobile ? 20 : 24,
                //       ),
                //     )
                //         .animate(
                //           onPlay: (controller) => controller.repeat(reverse: true),
                //         )
                //         .rotate(
                //           begin: -0.14,
                //           end: 0.14,
                //           duration: 450.ms,
                //           curve: Curves.easeInOut,
                //         ),
                //     const SizedBox(width: 10),
                //     // Text(
                //     //   "Hi! I'm Animesh",
                //     //   style: GoogleFonts.fraunces(
                //     //     fontSize: widget.isMobile ? 14 : 16,
                //     //     fontWeight: FontWeight.w600,
                //     //     color: ink(context),
                //     //   ),
                //     // ),
                //   ],
                // ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 500.ms)
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.elasticOut,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


class _HeroContent extends StatelessWidget {
  final PortfolioController c;
  const _HeroContent({required this.c});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    double fontSize = 58;
    if (isMobile) {
      fontSize = 36;
    } else if (isTablet) {
      fontSize = 46;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 14, 6),
          decoration: BoxDecoration(
            color: bg3(context),
            border: Border.all(color: line2(context)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 7, height: 7,
                decoration: BoxDecoration(
                  color: accent(context),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Open to opportunities · Lucknow, India',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12, color: ink2(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 24),

        // Headline with typed text
        Obx(() => RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Building apps\nthat ',
              style: GoogleFonts.fraunces(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: ink(context),
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: 'actually',
              style: GoogleFonts.fraunces(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: accent(context),
                fontStyle: FontStyle.italic,
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: '\nship to ',
              style: GoogleFonts.fraunces(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: ink(context),
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: c.typedText.value,
              style: GoogleFonts.fraunces(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                height: 1.05,
                letterSpacing: -1.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.5
                  ..color = ink(context),
              ),
            ),
            WidgetSpan(
              child: Obx(() => AnimatedOpacity(
                opacity: c.showCursor.value ? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 3, height: fontSize * 0.9,
                  margin: const EdgeInsets.only(left: 2, bottom: 4),
                  color: accent(context),
                ),
              )),
            ),
          ]),
        )).animate().fadeIn(duration: 700.ms, delay: 100.ms),

        const SizedBox(height: 24),

        Text(
          "I'm Animesh Pratap Singh — Android & Flutter developer with 4+ years building high-impact mobile solutions in Java, Kotlin, and Flutter. From first wireframe to Play Store release, solo.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.75,
          ),
        ).animate().fadeIn(duration: 700.ms, delay: 200.ms),

        const SizedBox(height: 32),

        // CTA buttons including Resume Download
        Wrap(
          spacing: 12, runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _HeroBtn(
              label: 'See the work ↓',
              primary: true,
              onTap: () => c.scrollToSection(c.workKey),
            ),
            _HeroBtn(
              label: 'Get in touch',
              primary: false,
              onTap: () => c.scrollToSection(c.contactKey),
            ),
            // Resume Download CTA
            ResumeButton(resumeUrl: c.resumeUrl),
          ],
        ).animate().fadeIn(duration: 700.ms, delay: 300.ms),

        const SizedBox(height: 28),

        // Social Links Row
        Row(
          children: c.socialLinks
              .map((s) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SocialIconButton(social: s),
                  ))
              .toList(),
        ).animate().fadeIn(duration: 700.ms, delay: 350.ms),

        const SizedBox(height: 48),

        // Stats
        Container(
          padding: const EdgeInsets.only(top: 32),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: line(context))),
          ),
          child: Wrap(
            spacing: 36, runSpacing: 20,
            children: const [
              _StatItem(number: '4+', label: 'years exp'),
              _StatItem(number: '6', label: 'apps shipped'),
              _StatItem(number: 'API 34', label: 'latest target'),
            ],
          ).animate().fadeIn(duration: 700.ms, delay: 400.ms),
        ),
      ],
    );
  }
}

class _HeroBtn extends StatefulWidget {
  final String label;
  final bool primary;
  final VoidCallback onTap;
  const _HeroBtn({required this.label, required this.primary, required this.onTap});

  @override
  State<_HeroBtn> createState() => _HeroBtnState();
}

class _HeroBtnState extends State<_HeroBtn> {
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
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovered ? accentHover(context) : accent(context))
                : (_hovered ? bg3(context) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.primary
                  ? accent(context)
                  : line2(context),
            ),
            boxShadow: widget.primary && _hovered
                ? [
                    BoxShadow(
                      color: accent(context).withOpacity(0.35),
                      blurRadius: 20, offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w500,
              color: widget.primary ? accentInk(context) : ink(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number,
          style: GoogleFonts.fraunces(
            fontSize: 30, fontWeight: FontWeight.w500, color: ink(context),
          )),
        const SizedBox(height: 3),
        Text(label,
          style: GoogleFonts.inter(fontSize: 12, color: ink3(context))),
      ],
    );
  }
}
