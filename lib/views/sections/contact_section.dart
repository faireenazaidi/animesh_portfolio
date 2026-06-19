import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: c.contactKey,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              Text('GET IN TOUCH',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11, letterSpacing: 1.0, color: AppColors.accent,
                )),
              const SizedBox(height: 20),
              Text(
                'Have an Android app\nto build or fix?',
                textAlign: TextAlign.center,
                style: GoogleFonts.fraunces(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.w400,
                  color: ink(context),
                  height: 1.1,
                  letterSpacing: -1.0,
                ),
              ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              Text(
                'Open to freelance and full-time roles.\nBased in Lucknow, available remotely.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 17, color: ink2(context), height: 1.65,
                ),
              ).animate().fadeIn(duration: 700.ms, delay: 100.ms),
              const SizedBox(height: 44),
              Wrap(
                spacing: 16, runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _ContactCard(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: 'Animesh.singh222@gmail.com',
                    onTap: () => launchUrl(
                      Uri.parse('mailto:Animesh.singh222@gmail.com'),
                    ),
                  ),
                  _ContactCard(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: '+91 9807039752',
                    onTap: () => launchUrl(
                      Uri.parse('tel:+919807039752'),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 700.ms, delay: 200.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          constraints: const BoxConstraints(minWidth: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          decoration: BoxDecoration(
            color: bg2(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.3)
                  : line2(context),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon,
                  color: AppColors.accentInk, size: 22),
              ),
              const SizedBox(height: 10),
              Text(widget.title,
                style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w600,
                  color: ink(context),
                )),
              const SizedBox(height: 4),
              Text(widget.value,
                style: GoogleFonts.inter(
                  fontSize: 12, color: ink3(context),
                ),
                overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
