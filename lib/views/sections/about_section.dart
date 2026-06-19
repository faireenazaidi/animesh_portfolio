import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

    return Container(
      key: c.aboutKey,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: isMobile ? _MobileAbout(c: c) : _DesktopAbout(c: c),
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
          child: _ProfileCard().animate().fadeIn(duration: 700.ms).slideY(begin: 0.2, end: 0),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 12,
          child: _AboutBody(c: c).animate().fadeIn(duration: 700.ms, delay: 150.ms).slideY(begin: 0.15, end: 0),
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
        _ProfileCard(),
        const SizedBox(height: 40),
        _AboutBody(c: c),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = ['Java', 'Kotlin', 'Flutter', 'Firebase',
      'SQLite', 'REST APIs', 'MongoDB', 'Material Design'];

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
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text('AP',
                style: GoogleFonts.fraunces(
                  fontSize: 26, fontWeight: FontWeight.w400,
                  color: AppColors.accentInk,
                )),
            ),
          ),
          const SizedBox(height: 20),
          Text('Animesh Pratap Singh',
            style: GoogleFonts.fraunces(
              fontSize: 22, fontWeight: FontWeight.w400, color: ink(context),
            )),
          const SizedBox(height: 4),
          Text('Android Developer · Criterion Tech',
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
          eyebrow: 'ABOUT',
          title: 'Background',
        ),
        const SizedBox(height: 28),
        Text(
          "Four-plus years building Android apps end to end — design, development, deployment, and maintenance. Currently at Criterion Tech in Lucknow across the full software lifecycle: requirements, UI, code, testing, and Play Store delivery.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          "Java and Kotlin for native Android, Flutter when the project needs a cross-platform path, and Firebase for auth, push, analytics, and crash reporting. Integrated Google, Facebook, Twitter, and LinkedIn login flows, Maps and YouTube APIs.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 18),
        Text("GNIIT in Cloud Software Engineering from NIIT Lucknow, B.Com from Avadh University.",
          style: GoogleFonts.inter(
            fontSize: 16, color: ink2(context), height: 1.8,
          ),
        ),
        const SizedBox(height: 36),
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
