import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: c.heroKey,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 140,
        bottom: 80,
        left: isMobile ? 20 : 32,
        right: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: isMobile
              ? _MobileHero(c: c)
              : _DesktopHero(c: c),
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
        const SizedBox(width: 60),
        Expanded(
          flex: 9,
          child: Center(
            child: PhoneFrame(
              imageUrls: const [
                'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=420&h=900&fit=crop&q=80',
                'https://images.unsplash.com/photo-1631815588090-d4bfec5b1b98?w=420&h=900&fit=crop&q=80',
                'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=420&h=900&fit=crop&q=80',
              ],
            ).animate().fadeIn(duration: 800.ms, delay: 300.ms)
              .slideY(begin: 0.3, end: 0),
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
        const SizedBox(height: 56),
        Center(
          child: PhoneFrame(
            imageUrls: const [
              'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=420&h=900&fit=crop&q=80',
              'https://images.unsplash.com/photo-1631815588090-d4bfec5b1b98?w=420&h=900&fit=crop&q=80',
              'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=420&h=900&fit=crop&q=80',
            ],
            width: 200,
            height: 420,
          ).animate().fadeIn(duration: 800.ms, delay: 300.ms),
        ),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  final PortfolioController c;
  const _HeroContent({required this.c});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.fromLTRB(8, 6, 14, 6),
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
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Open to opportunities · Lucknow',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12, color: ink2(context),
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
                fontSize: isMobile ? 36 : 58,
                fontWeight: FontWeight.w400,
                color: ink(context),
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: 'actually',
              style: GoogleFonts.fraunces(
                fontSize: isMobile ? 36 : 58,
                fontWeight: FontWeight.w400,
                color: AppColors.accent,
                fontStyle: FontStyle.italic,
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: '\nship to ',
              style: GoogleFonts.fraunces(
                fontSize: isMobile ? 36 : 58,
                fontWeight: FontWeight.w400,
                color: ink(context),
                height: 1.05,
                letterSpacing: -1.0,
              ),
            ),
            TextSpan(
              text: c.typedText.value,
              style: GoogleFonts.fraunces(
                fontSize: isMobile ? 36 : 58,
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
                  width: 3, height: isMobile ? 34 : 52,
                  margin: const EdgeInsets.only(left: 2, bottom: 4),
                  color: AppColors.accent,
                ),
              )),
            ),
          ]),
        )).animate().fadeIn(duration: 700.ms, delay: 100.ms),

        const SizedBox(height: 24),

        Text(
          "I'm Animesh Pratap Singh — Android developer with 4+ years in Java, Kotlin, and Flutter. From first wireframe to Play Store, solo.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.75,
          ),
          maxLines: 4,
        ).animate().fadeIn(duration: 700.ms, delay: 200.ms),

        const SizedBox(height: 36),

        // CTA buttons
        Wrap(
          spacing: 12, runSpacing: 12,
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
          ],
        ).animate().fadeIn(duration: 700.ms, delay: 300.ms),

        const SizedBox(height: 52),

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
                ? (_hovered ? const Color(0xFFD4FF70) : AppColors.accent)
                : (_hovered ? bg3(context) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.primary
                  ? AppColors.accent
                  : line2(context),
            ),
            boxShadow: widget.primary && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.35),
                      blurRadius: 20, offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w500,
              color: widget.primary ? AppColors.accentInk : ink(context),
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
