import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: c.skillsKey,
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
                  eyebrow: 'EXPERTISE & STACK',
                  title: 'Skills & Technical Proficiency',
                  subtitle:
                      'Core technologies, frameworks, and architecture patterns I use to ship production apps.',
                ),
              ),
              const SizedBox(height: 48),

              // ── Categorized Skill Tags Layout ──
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = Responsive.isDesktop(context);
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 20) / 2
                      : double.infinity;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(c.skillCategories.length, (index) {
                      final cat = c.skillCategories[index];
                      return SizedBox(
                        width: cardWidth,
                        child: ScrollAnimate(
                          delay: Duration(milliseconds: index * 80),
                          child: _SkillCategoryCard(category: cat),
                        ),
                      );
                    }),
                  );
                },
              ),

              const SizedBox(height: 56),

              // ── Proficiency Bars Header ──
              ScrollAnimate(
                child: Text(
                  'Core Proficiency Ratings',
                  style: GoogleFonts.fraunces(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: ink(context),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Skill Bars Grid ──
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = Responsive.isDesktop(context);
                  final barWidth = isDesktop
                      ? (constraints.maxWidth - 16) / 2
                      : double.infinity;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(c.skills.length, (i) {
                      return SizedBox(
                        width: barWidth,
                        child: ScrollAnimate(
                          delay: Duration(milliseconds: i * 50),
                          child: SkillBarCard(skill: c.skills[i]),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategoryModel category;
  const _SkillCategoryCard({required this.category});

  IconData _getCategoryIcon(String name) {
    if (name.contains('Native')) return Icons.android_rounded;
    if (name.contains('Cross-Platform') || name.contains('Mobile')) return Icons.phonelink_setup_rounded;
    if (name.contains('Backend') || name.contains('Cloud')) return Icons.cloud_done_rounded;
    return Icons.architecture_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bg2(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: line2(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: accent(context).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getCategoryIcon(category.categoryName),
                  color: accent(context),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.categoryName,
                  style: GoogleFonts.fraunces(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ink(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: category.skills
                .map((skill) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: bg3(context),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: line(context)),
                      ),
                      child: Text(
                        skill,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: ink2(context),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
