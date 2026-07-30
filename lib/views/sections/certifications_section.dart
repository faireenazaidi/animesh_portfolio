import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Container(
      key: c.certsKey,
      padding: EdgeInsets.symmetric(
        vertical: 90,
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
                  eyebrow: 'CREDENTIALS',
                  title: 'Certifications',
                  subtitle:
                      'Recognized qualifications and specialized technical training.',
                ),
              ),
              const SizedBox(height: 48),

              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(c.certifications.length, (index) {
                      final cert = c.certifications[index];
                      return SizedBox(
                        width: isMobile ? double.infinity : itemWidth,
                        child: ScrollAnimate(
                          delay: Duration(milliseconds: index * 100),
                          child: _CertCard(cert: cert),
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

class _CertCard extends StatefulWidget {
  final CertificationModel cert;
  const _CertCard({required this.cert});

  @override
  State<_CertCard> createState() => _CertCardState();
}

class _CertCardState extends State<_CertCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hasUrl = widget.cert.credentialUrl != null &&
        widget.cert.credentialUrl!.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: hasUrl ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () async {
          if (hasUrl) {
            final uri = Uri.parse(widget.cert.credentialUrl!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              Matrix4.translationValues(0, _hovered && hasUrl ? -4 : 0, 0),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: bg2(context),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered && hasUrl
                  ? accent(context).withOpacity(0.4)
                  : line2(context),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accent(context).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.workspace_premium_rounded,
                      color: accent(context),
                      size: 24,
                    ),
                  ),
                  Text(
                    widget.cert.year,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: accent(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                widget.cert.title,
                style: GoogleFonts.fraunces(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: ink(context),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.cert.issuer,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: ink3(context),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    hasUrl ? 'Verify Credential' : 'Verified Certificate',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: hasUrl ? accent(context) : ink3(context),
                    ),
                  ),
                  if (hasUrl) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 14,
                      color: accent(context),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
