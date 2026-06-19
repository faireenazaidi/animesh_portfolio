import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: c.workKey,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'SELECTED WORK',
                title: 'Apps built end to end.',
                subtitle:
                    'Healthcare, nutrition, clinical reference, exam prep — each designed, built, tested, and shipped.',
              ),
              const SizedBox(height: 72),
              ...List.generate(c.projects.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: _ProjectRow(
                    project: c.projects[i],
                    flip: !isMobile && i % 2 == 1,
                    isMobile: isMobile,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final ProjectModel project;
  final bool flip;
  final bool isMobile;

  const _ProjectRow({
    required this.project,
    required this.flip,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final Widget phoneWidget = PhoneFrame(
      imageUrls: project.imageUrls,
      width: 210,
      height: 440,
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0);

    final Widget infoWidget = _ProjectInfo(project: project)
        .animate()
        .fadeIn(duration: 700.ms, delay: 120.ms)
        .slideY(begin: 0.15, end: 0);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: phoneWidget),
          const SizedBox(height: 40),
          infoWidget,
        ],
      );
    }

    if (flip) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: infoWidget),
          const SizedBox(width: 80),
          Expanded(child: Center(child: phoneWidget)),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Center(child: phoneWidget)),
        const SizedBox(width: 80),
        Expanded(child: infoWidget),
      ],
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  final ProjectModel project;
  const _ProjectInfo({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${project.index} / app',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: ink3(context),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.name,
          style: GoogleFonts.fraunces(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: ink(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.tagline,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          project.description,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: ink2(context),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: project.stack.map((s) => StackPill(s)).toList(),
        ),
        const SizedBox(height: 26),
        AppLinkCard(
          title: project.link.isEmpty ? 'Internal project' : 'On Google Play',
          subtitle: project.link.isEmpty
              ? 'Contact for details'
              : project.link.replaceFirst('https://', ''),
          url: project.link.isEmpty ? null : project.link,
        ),
      ],
    );
  }
}
