import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
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
              const SectionHeader(
                eyebrow: 'EXPERTISE',
                title: 'Skills & proficiency.',
                subtitle: 'Technologies I use daily and have shipped production apps with.',
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isMobile ? 4.5 : 5,
                ),
                itemCount: c.skills.length,
                itemBuilder: (_, i) => SkillBarCard(skill: c.skills[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
