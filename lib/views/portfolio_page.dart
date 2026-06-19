import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import 'sections/hero_section.dart';
import 'sections/marquee_section.dart';
import 'sections/skills_section.dart';
import 'sections/work_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'widgets/shared_widgets.dart';

class PortfolioPage extends GetView<PortfolioController> {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ScrollProgressBar(),
            AppNavBar(),
          ],
        ),
      ),

      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSection(),
            const Divider(height: 1),
            const MarqueeSection(),
            const Divider(height: 1),
            const SkillsSection(),
            const Divider(height: 1),
            const WorkSection(),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('© 2026 Animesh Pratap Singh',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF5C5B55)
                        : const Color(0xFF9B9A93),
                  )),
          Text('Lucknow, India',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF5C5B55)
                        : const Color(0xFF9B9A93),
                  )),
        ],
      ),
    );
  }
}
