import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class NowSection extends StatelessWidget {
  const NowSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final now = c.nowData;

    return Container(
      key: c.nowKey,
      padding: EdgeInsets.symmetric(
        vertical: 90,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: ScrollAnimate(
            child: Container(
              padding: EdgeInsets.all(isMobile ? 24 : 40),
              decoration: BoxDecoration(
                color: bg2(context),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: line2(context)),
                boxShadow: [
                  BoxShadow(
                    color: accent(context).withOpacity(0.05),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Status Badge (Responsive Wrap)
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: accent(context).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: accent(context).withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: accent(context),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              now.status,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: accent(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        now.lastUpdated,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          color: ink3(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Section Title
                  Text(
                    'CURRENTLY BUILDING',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: accent(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    now.projectTitle,
                    style: GoogleFonts.fraunces(
                      fontSize: isMobile ? 26 : 38,
                      fontWeight: FontWeight.w400,
                      color: ink(context),
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    now.description,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: ink2(context),
                      height: 1.75,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tech Stack Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: now.techStack
                        .map((tech) => StackPill(tech))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
