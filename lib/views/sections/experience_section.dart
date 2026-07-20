import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

// TODO: Customize experience entries in portfolio_controller.dart (experiences)
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: c.experienceKey,
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
                  eyebrow: 'CAREER PATH',
                  title: 'Work Experience',
                  subtitle:
                      '4+ years building production mobile apps, leading releases, and handling end-to-end features.',
                ),
              ),
              const SizedBox(height: 56),

              // Timeline List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: c.experiences.length,
                itemBuilder: (context, index) {
                  final exp = c.experiences[index];
                  final isLast = index == c.experiences.length - 1;

                  return ScrollAnimate(
                    delay: Duration(milliseconds: index * 150),
                    child: _ExperienceTimelineTile(
                      experience: exp,
                      isLast: isLast,
                      isMobile: isMobile,
                    ),
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

class _ExperienceTimelineTile extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;
  final bool isMobile;

  const _ExperienceTimelineTile({
    required this.experience,
    required this.isLast,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Node & Bar
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: accent(context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: bg(context),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent(context).withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: line2(context),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),

          // Content Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.all(isMobile ? 20 : 28),
              decoration: BoxDecoration(
                color: bg2(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: line2(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Period & Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        experience.period,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: accent(context),
                        ),
                      ),
                      Text(
                        experience.location,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: ink3(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Role & Company
                  Text(
                    experience.role,
                    style: GoogleFonts.fraunces(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: ink(context),
                    ),
                  ),
                  Text(
                    experience.company,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ink2(context),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Description
                  Text(
                    experience.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: ink2(context),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Key Highlights
                  ...experience.highlights.map((h) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ',
                                style: TextStyle(
                                    color: accent(context), fontSize: 16)),
                            Expanded(
                              child: Text(
                                h,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: ink2(context),
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 18),

                  // Tech Stack Pills
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: experience.techStack
                        .map((t) => StackPill(t))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
