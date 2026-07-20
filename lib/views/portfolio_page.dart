import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/portfolio_controller.dart';
import 'sections/hero_section.dart';
import 'sections/marquee_section.dart';
import 'sections/now_section.dart';
import 'sections/work_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/certifications_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'widgets/shared_widgets.dart';

class PortfolioPage extends GetView<PortfolioController> {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(71),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ScrollProgressBar(),
            AppNavBar(),
          ],
        ),
      ),

      // Responsive Mobile Navigation Drawer
      endDrawer: const MobileNavDrawer(),

      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSection(),
            const Divider(height: 1),
            const MarqueeSection(),
            const Divider(height: 1),
            const NowSection(),
            const Divider(height: 1),
            const WorkSection(),
            const Divider(height: 1),
            const SkillsSection(),
            const Divider(height: 1),
            const ExperienceSection(),
            const Divider(height: 1),
            const CertificationsSection(),
            const Divider(height: 1),
            const TestimonialsSection(),
            const Divider(height: 1),
            const AboutSection(),
            const Divider(height: 1),
            const ContactSection(),
            const _Footer(),
          ],
        ),
      ),

      // ── Floating back-to-top ──
      floatingActionButton: const BackToTopButton(),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: isMobile ? 20 : 32,
      ),
      decoration: BoxDecoration(
        color: bg2(context),
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: isMobile
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: c.socialLinks
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: SocialIconButton(social: s),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 Animesh Pratap Singh · Built with Flutter',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ink3(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lucknow, India',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ink3(context),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2026 Animesh Pratap Singh · Built with Flutter',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: ink3(context),
                      ),
                    ),
                    Row(
                      children: c.socialLinks
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: SocialIconButton(social: s),
                              ))
                          .toList(),
                    ),
                    Text(
                      'Lucknow, India',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: ink3(context),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
