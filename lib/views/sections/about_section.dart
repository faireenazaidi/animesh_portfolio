import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      key: c.aboutKey,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: isDesktop ? _DesktopAbout(c: c) : _MobileAbout(c: c),
        ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  final PortfolioController c;
  const _DesktopAbout({required this.c});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: ScrollAnimate(
            child: _ProfileCard(c: c),
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 12,
          child: ScrollAnimate(
            delay: const Duration(milliseconds: 150),
            child: _AboutBody(c: c),
          ),
        ),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  final PortfolioController c;
  const _MobileAbout({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollAnimate(child: _ProfileCard(c: c)),
        const SizedBox(height: 40),
        ScrollAnimate(delay: const Duration(milliseconds: 150), child: _AboutBody(c: c)),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final PortfolioController c;
  const _ProfileCard({required this.c});

  @override
  Widget build(BuildContext context) {
    final skills = ['Java', 'Kotlin', 'Flutter', 'Firebase',
      'SQLite', 'REST APIs', 'Room DB', 'Material 3'];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: bg2(context),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: line2(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              color: accent(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text('AP',
                style: GoogleFonts.fraunces(
                  fontSize: 26, fontWeight: FontWeight.w400,
                  color: accentInk(context),
                )),
            ),
          ),
          const SizedBox(height: 20),
          Text('Animesh Pratap Singh',
            style: GoogleFonts.fraunces(
              fontSize: 24, fontWeight: FontWeight.w400, color: ink(context),
            )),
          const SizedBox(height: 4),
          Text('Android & Flutter Developer · Criterion Tech',
            style: GoogleFonts.inter(fontSize: 13, color: ink3(context))),
          const SizedBox(height: 20),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: skills.map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: bg3(context),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: line(context)),
              ),
              child: Text(s,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11, color: ink2(context),
                )),
            )).toList(),
          ),
          const SizedBox(height: 28),
          // Download CV Button
          ResumeButton(resumeUrl: c.resumeUrl, fullWidth: true),
        ],
      ),
    );
  }
}

class _AboutBody extends StatelessWidget {
  final PortfolioController c;
  const _AboutBody({required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: 'ABOUT ME',
          title: 'Background & Philosophy',
        ),
        const SizedBox(height: 28),
        Text(
          "Four-plus years building production mobile applications end-to-end — architectural planning, UI/UX design implementation, backend integration, testing, and Google Play Store delivery.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          "Currently at Criterion Tech in Lucknow, handling the full software development lifecycle. Specialized in native Java & Kotlin alongside cross-platform Flutter. Built healthcare suites, clinical decision support tools, nutritional calculators, and exam prep portals.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          "GNIIT distinction graduate in Cloud Software Engineering from NIIT Lucknow, B.Com from Avadh University.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 36),
        Text(
          'Academic Background',
          style: GoogleFonts.fraunces(
            fontSize: 20, fontWeight: FontWeight.w400, color: ink(context),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: line(context))),
          ),
          child: Column(
            children: c.education
                .map((e) => EduRow(edu: e))
                .toList(),
          ),
        ),
      ],
    );
  }
}
