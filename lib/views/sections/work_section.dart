import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

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
              const ScrollAnimate(
                child: SectionHeader(
                  eyebrow: 'SELECTED WORK',
                  title: 'Apps Built & Shipped',
                  subtitle:
                      'Healthcare suites, food nutrition breakdowns, clinical tools, exam prep — built, tested, and shipped end-to-end.',
                ),
              ),
              const SizedBox(height: 72),
              ...List.generate(c.projects.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: ScrollAnimate(
                    child: _ProjectRow(
                      project: c.projects[i],
                      flip: isDesktop && i % 2 == 1,
                      isDesktop: isDesktop,
                    ),
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
  final bool isDesktop;

  const _ProjectRow({
    required this.project,
    required this.flip,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final Widget phoneWidget = PhoneFrame(
      imageUrls: project.imageUrls,
      width: 210,
      height: 440,
    );

    final Widget infoWidget = _ProjectInfo(project: project);

    if (!isDesktop) {
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
    final hasPlayStore = project.link.isNotEmpty;
    final hasGithub = project.githubLink != null && project.githubLink!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${project.index} / FEATURED APP',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: ink3(context),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.name,
          style: GoogleFonts.fraunces(
            fontSize: 32,
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
            color: accent(context),
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

        // Action Link Cards (Play Store & GitHub)
        Column(
          children: [
            AppLinkCard(
              title: hasPlayStore ? 'Live on Google Play' : 'Internal Clinical Project',
              subtitle: hasPlayStore
                  ? project.link.replaceFirst('https://', '')
                  : 'Built for specialized clinical workflow',
              url: hasPlayStore ? project.link : null,
              icon: Icons.shop_rounded,
            ),
            if (hasGithub) ...[
              const SizedBox(height: 12),
              AppLinkCard(
                title: 'GitHub Source Code',
                subtitle: project.githubLink!.replaceFirst('https://', ''),
                url: project.githubLink,
                icon: Icons.code_rounded,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
