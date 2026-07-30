import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/models.dart';
import '../../utils/responsive.dart';
import '../widgets/shared_widgets.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      key: c.testimonialsKey,
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
                  eyebrow: 'ENDORSEMENTS',
                  title: 'Testimonials & Reviews',
                  subtitle:
                      'What product leads and engineering partners say about working with me.',
                ),
              ),
              const SizedBox(height: 48),

              if (isDesktop)
                // 2-Column Responsive Layout for Desktop
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(c.testimonials.length, (index) {
                    final t = c.testimonials[index];
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 12,
                          right: index == c.testimonials.length - 1 ? 0 : 12,
                        ),
                        child: ScrollAnimate(
                          delay: Duration(milliseconds: index * 120),
                          child: _TestimonialCard(testimonial: t),
                        ),
                      ),
                    );
                  }),
                )
              else
                // 1-Column Dynamic Stack for Mobile & Tablet
                Column(
                  children: List.generate(c.testimonials.length, (index) {
                    final t = c.testimonials[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ScrollAnimate(
                        delay: Duration(milliseconds: index * 120),
                        child: _TestimonialCard(testimonial: t),
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final TestimonialModel testimonial;
  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: bg2(context),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: line2(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quote Mark Icon
          Icon(
            Icons.format_quote_rounded,
            size: 36,
            color: accent(context).withOpacity(0.6),
          ),
          const SizedBox(height: 12),

          // Quote text
          Text(
            '"${testimonial.quote}"',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: ink(context),
              height: 1.65,
            ),
          ),

          const SizedBox(height: 24),

          // Author details
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent(context),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    testimonial.author[0],
                    style: GoogleFonts.fraunces(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: accentInk(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.author,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ink(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${testimonial.title} · ${testimonial.company}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ink3(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
