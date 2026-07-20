import 'package:flutter/material.dart';
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
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              ScrollAnimate(
                child: Column(
                  children: [
                    Text(
                      'GET IN TOUCH',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                        color: accent(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Have a mobile app\nto build or improve?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fraunces(
                        fontSize: isMobile ? 36 : 56,
                        fontWeight: FontWeight.w400,
                        color: ink(context),
                        height: 1.1,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Open to full-time engineering roles, high-impact freelance projects, and consulting.\nBased in Lucknow, India · Available worldwide.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: ink2(context),
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Contact Cards (Email & Phone)
              ScrollAnimate(
                delay: const Duration(milliseconds: 100),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
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
                ),
              ),

              const SizedBox(height: 56),

              // Interactive Contact Form
              ScrollAnimate(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 24 : 36),
                  decoration: BoxDecoration(
                    color: bg2(context),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: line2(context)),
                  ),
                  child: Form(
                    key: c.contactFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send Me a Message',
                          style: GoogleFonts.fraunces(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: ink(context),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Fill out the form below and I will get back to you within 24 hours.',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ink3(context),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Form Inputs
                        if (isMobile) ...[
                          _FormField(
                            controller: c.nameController,
                            label: 'Your Name',
                            hint: 'e.g. John Doe',
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Please enter your name' : null,
                          ),
                          const SizedBox(height: 16),
                          _FormField(
                            controller: c.emailController,
                            label: 'Email Address',
                            hint: 'e.g. john@example.com',
                            validator: (v) =>
                                v == null || !v.contains('@') ? 'Please enter a valid email' : null,
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Expanded(
                                child: _FormField(
                                  controller: c.nameController,
                                  label: 'Your Name',
                                  hint: 'e.g. John Doe',
                                  validator: (v) => v == null || v.isEmpty
                                      ? 'Please enter your name'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _FormField(
                                  controller: c.emailController,
                                  label: 'Email Address',
                                  hint: 'e.g. john@example.com',
                                  validator: (v) => v == null || !v.contains('@')
                                      ? 'Please enter a valid email'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),

                        _FormField(
                          controller: c.subjectController,
                          label: 'Subject',
                          hint: 'e.g. Mobile App Development Project',
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Please enter a subject' : null,
                        ),
                        const SizedBox(height: 16),

                        _FormField(
                          controller: c.messageController,
                          label: 'Message',
                          hint: 'Describe your project requirements or question...',
                          maxLines: 4,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Please enter your message' : null,
                        ),
                        const SizedBox(height: 28),

                        // Submit Button
                        Obx(() => SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: c.isSubmittingContact.value
                                    ? null
                                    : c.submitContactForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accent(context),
                                  foregroundColor: accentInk(context),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: c.isSubmittingContact.value
                                    ? SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: accentInk(context),
                                        ),
                                      )
                                    : Text(
                                        'Send Message →',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Social Links Bar
              ScrollAnimate(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Text(
                      'Connect Across the Web',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ink3(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: c.socialLinks
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SocialIconButton(social: s),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: ink(context),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.inter(fontSize: 14, color: ink(context)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(fontSize: 14, color: ink3(context)),
            filled: true,
            fillColor: bg3(context),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: line2(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: line2(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: accent(context)),
            ),
          ),
        ),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: bg2(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? accent(context).withOpacity(0.4)
                  : line2(context),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: accent(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon,
                  color: accentInk(context), size: 22),
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
