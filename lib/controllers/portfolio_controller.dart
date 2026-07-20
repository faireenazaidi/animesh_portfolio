import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class PortfolioController extends GetxController {
  final isDark = false.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  // ── Scroll Controller & Navigation Keys ──
  final scrollController = ScrollController();
  final scrollProgress = 0.0.obs;
  final showBackToTop = false.obs;

  final heroKey = GlobalKey();
  final nowKey = GlobalKey();
  final workKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final certsKey = GlobalKey();
  final testimonialsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void onScroll() {
    final max = scrollController.position.maxScrollExtent;
    if (max > 0) {
      scrollProgress.value = scrollController.offset / max;
    }
    showBackToTop.value = scrollController.offset > 400;
  }

  // ── Hero Animated Typing ──
  final typedText = ''.obs;
  final showCursor = true.obs;
  final _words = ['Google Play.', 'the world.', 'millions.'];
  int _wordIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  Timer? _typeTimer;
  Timer? _cursorTimer;

  void _startTyping() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      showCursor.value = !showCursor.value;
    });

    Future.delayed(const Duration(milliseconds: 800), _typeLoop);
  }

  void _typeLoop() {
    final word = _words[_wordIndex];
    if (!_deleting) {
      typedText.value = word.substring(0, _charIndex + 1);
      _charIndex++;
      if (_charIndex == word.length) {
        _deleting = true;
        _typeTimer = Timer(const Duration(milliseconds: 1600), _typeLoop);
        return;
      }
    } else {
      typedText.value = word.substring(0, _charIndex - 1);
      _charIndex--;
      if (_charIndex == 0) {
        _deleting = false;
        _wordIndex = (_wordIndex + 1) % _words.length;
        _typeTimer = Timer(const Duration(milliseconds: 400), _typeLoop);
        return;
      }
    }
    final delay = _deleting
        ? const Duration(milliseconds: 60)
        : const Duration(milliseconds: 90);
    _typeTimer = Timer(delay, _typeLoop);
  }

  // ── TODO: Resume Link Placeholder ──
  // Replace this URL with your hosted resume PDF (e.g. Google Drive link or static web link)
  final String resumeUrl = 'https://example.com/Animesh_Pratap_Singh_Resume.pdf'; // TODO: Update with your real Resume PDF URL

  // ── Social Links ──
  final socialLinks = const <SocialLinkModel>[
    SocialLinkModel(
      platform: 'GitHub',
      url: 'https://github.com/AnimeshPratapSingh', // TODO: Update with your GitHub profile link
    ),
    SocialLinkModel(
      platform: 'LinkedIn',
      url: 'https://linkedin.com/in/animesh-pratap-singh', // TODO: Update with your LinkedIn profile link
    ),
    SocialLinkModel(
      platform: 'Twitter / X',
      url: 'https://twitter.com/animesh_dev', // TODO: Update with your Twitter/X profile link
    ),
    SocialLinkModel(
      platform: 'Email',
      url: 'mailto:Animesh.singh222@gmail.com',
    ),
  ];

  // ── "Currently Working On" / Now Section ──
  final nowData = const NowModel(
    projectTitle: 'Smart Healthcare Mobile Suite in Flutter',
    status: 'In Active Development',
    description:
        'Building a cross-platform Flutter application featuring real-time doctor appointment sync, encrypted health records, offline-first SQLite database architecture, and custom interactive health metric charts.',
    techStack: ['Flutter', 'Dart', 'GetX', 'SQLite', 'Firebase', 'REST APIs'],
    lastUpdated: 'Updated July 2026',
  );

  // ── Projects ──
  final projects = <ProjectModel>[
    const ProjectModel(
      name: 'Digi Doctor',
      tagline: 'Medical records, appointments & video consultations.',
      description:
          'Patients manage medication, investigations, drug allergies, and admission history — plus appointment booking, video calls with doctors, online pharmacy and lab test booking. Built and designed solo.',
      stack: ['Java', 'Firebase', 'Android Studio', 'REST APIs'],
      link: 'https://play.google.com/store/apps/details?id=com.digidoctor.android',
      githubLink: 'https://github.com/AnimeshPratapSingh/DigiDoctor', // TODO: Replace with GitHub repo link if public
      imageUrls: [
        'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1631815588090-d4bfec5b1b98?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=420&h=900&fit=crop&q=80',
      ],
      index: '01',
    ),
    const ProjectModel(
      name: 'Nutrition Today',
      tagline: 'Full nutritional breakdown for everyday foods.',
      description:
          'Search any food and see its complete nutritional profile and compound breakdown instantly. Handled development, UI design, and manual testing end to end.',
      stack: ['Java', 'SQLite', 'Android Studio', 'Material Design'],
      link: 'https://play.google.com/store/apps/details?id=com.nutritiontoday.android',
      githubLink: 'https://github.com/AnimeshPratapSingh/NutritionToday', // TODO: Replace with GitHub repo link if public
      imageUrls: [
        'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1543362906-acfc16c67564?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1505253716362-afaea1d3d1af?w=420&h=900&fit=crop&q=80',
      ],
      index: '02',
    ),
    const ProjectModel(
      name: 'NutriAnalyser',
      tagline: 'Diet tracker with deficiency & toxicity alerts.',
      description:
          'Tracks a user\'s diet records alongside nutritional intake and proactively notifies them of nutrient or mineral deficiency and toxicity. Built and designed solo.',
      stack: ['Java', 'REST APIs', 'Android Studio', 'SQLite'],
      link: '',
      githubLink: 'https://github.com/AnimeshPratapSingh/NutriAnalyser', // TODO: Replace with GitHub repo link if public
      imageUrls: [
        'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1505253716362-afaea1d3d1af?w=420&h=900&fit=crop&q=80',
      ],
      index: '03',
    ),
    const ProjectModel(
      name: 'KnowMed Clinical',
      tagline: 'Disease, symptoms, medicine & lab reference.',
      description:
          'Clinical reference covering diseases, symptoms, lab results, medicine interactions, dietary recommendations by condition, and a built-in symptom checker. Solo project.',
      stack: ['Java', 'SQLite', 'Android Studio', 'REST APIs'],
      link: '',
      githubLink: 'https://github.com/AnimeshPratapSingh/KnowMedClinical', // TODO: Replace with GitHub repo link if public
      imageUrls: [
        'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=420&h=900&fit=crop&q=80',
      ],
      index: '04',
    ),
    const ProjectModel(
      name: 'KnowMedPrep',
      tagline: 'Exam prep & video tutorials for medical students.',
      description:
          'Hundreds of practice questions and video tutorials for medical exam prep — built for quick access on mobile. Two-person dev and QA team.',
      stack: ['Java', 'Firebase', 'Android Studio', 'Video Streaming API'],
      link: '',
      githubLink: 'https://github.com/AnimeshPratapSingh/KnowMedPrep', // TODO: Replace with GitHub repo link if public
      imageUrls: [
        'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=420&h=900&fit=crop&q=80',
      ],
      index: '05',
    ),
  ];

  // ── Skills & Proficiency ──
  final skills = <SkillModel>[
    const SkillModel(name: 'Java', percentage: 92),
    const SkillModel(name: 'Kotlin', percentage: 88),
    const SkillModel(name: 'Android SDK & Studio', percentage: 94),
    const SkillModel(name: 'Flutter & Dart', percentage: 82),
    const SkillModel(name: 'Firebase Suite', percentage: 88),
    const SkillModel(name: 'SQLite & Room DB', percentage: 86),
    const SkillModel(name: 'REST APIs & Retrofit', percentage: 88),
    const SkillModel(name: 'Material UI Design', percentage: 90),
  ];

  // ── Tagged Skill Categories ──
  final skillCategories = const <SkillCategoryModel>[
    SkillCategoryModel(
      categoryName: 'Native Android',
      skills: [
        'Java',
        'Kotlin',
        'Android SDK',
        'Jetpack',
        'Coroutines',
        'LiveData',
        'Room DB',
        'Retrofit',
        'MVVM'
      ],
    ),
    SkillCategoryModel(
      categoryName: 'Cross-Platform Mobile',
      skills: [
        'Flutter',
        'Dart',
        'GetX Architecture',
        'State Management',
        'Responsive UI',
        'Animations'
      ],
    ),
    SkillCategoryModel(
      categoryName: 'Backend & Cloud',
      skills: [
        'Firebase Auth',
        'Cloud Firestore',
        'Realtime DB',
        'Cloud Messaging (FCM)',
        'RESTful APIs',
        'JSON Parsing'
      ],
    ),
    SkillCategoryModel(
      categoryName: 'Tools & Architecture',
      skills: [
        'Git & GitHub',
        'Android Studio',
        'Postman',
        'Material Design 3',
        'Google Play Console',
        'OOP & Clean Code'
      ],
    ),
  ];

  // ── Experience / Career Timeline ──
  final experiences = const <ExperienceModel>[
    ExperienceModel(
      role: 'Android Developer',
      company: 'Criterion Tech',
      period: '2020 — Present',
      location: 'Lucknow, Uttar Pradesh, India',
      description:
          'Leading full-lifecycle mobile app development across healthcare, dietetics, and medical prep domains. Handling wireframing, architecture, backend API integration, testing, and Google Play Store deployment.',
      highlights: [
        'Architected and deployed 5+ production Android applications with thousands of active healthcare users.',
        'Integrated Firebase authentication, push notifications, video consultations, and real-time database sync.',
        'Implemented offline-first caching architectures using SQLite and Room Database to ensure uninterrupted offline availability.',
        'Collaborated directly with product teams, medical professionals, and QA engineers for rapid feature iterations.',
      ],
      techStack: ['Java', 'Kotlin', 'Flutter', 'Firebase', 'SQLite', 'REST APIs', 'Android Studio'],
    ),
    ExperienceModel(
      role: 'Software Developer Trainee',
      company: 'NIIT Technologies / Academic Projects',
      period: '2019 — 2020',
      location: 'Lucknow, India',
      description:
          'Underwent intensive GNIIT Cloud Software Engineering specialization. Developed core algorithms, relational database structures, and initial Android applications.',
      highlights: [
        'Graduated with 95% distinction in GNIIT Cloud Software Engineering curriculum.',
        'Mastered Object-Oriented Programming (OOP), Data Structures, and Software Development Life Cycle (SDLC).',
      ],
      techStack: ['Java', 'SQL', 'Data Structures', 'OOP', 'HTML/CSS'],
    ),
  ];

  // ── Certifications ──
  final certifications = const <CertificationModel>[
    CertificationModel(
      title: 'GNIIT — Cloud Software Engineering',
      issuer: 'NIIT Lucknow',
      year: '2020',
      credentialUrl: 'https://example.com/niit-cert', // TODO: Add credential verification URL
    ),
    CertificationModel(
      title: 'Android Application Development Specialization',
      issuer: 'Criterion Tech / NIIT',
      year: '2021',
      credentialUrl: 'https://example.com/android-cert', // TODO: Add credential verification URL
    ),
    CertificationModel(
      title: 'Flutter & Dart Cross-Platform Mobile Development',
      issuer: 'Professional Development',
      year: '2023',
      credentialUrl: 'https://example.com/flutter-cert', // TODO: Add credential verification URL
    ),
  ];

  // ── Testimonials & Recommendations ──
  final testimonials = const <TestimonialModel>[
    TestimonialModel(
      quote:
          'Animesh single-handedly designed and developed Digi Doctor from wireframes to Play Store release. His ability to turn complex healthcare requirements into intuitive mobile apps is outstanding.',
      author: 'Product Lead', // TODO: Update with real manager or client name
      title: 'Senior Manager',
      company: 'Criterion Tech',
    ),
    TestimonialModel(
      quote:
          'Working alongside Animesh on clinical reference and prep apps was seamless. His code quality, API integration skills, and quick bug resolution made all the difference.',
      author: 'Senior QA & Dev Partner', // TODO: Update with real colleague name
      title: 'Engineering Partner',
      company: 'Healthcare Solutions',
    ),
  ];

  // ── Education ──
  final education = <EducationModel>[
    const EducationModel(
        degree: 'GNIIT — Cloud Software Engineering',
        institute: 'NIIT, Lucknow',
        year: '2020',
        score: '95% Score'),
    const EducationModel(
        degree: 'Bachelor of Commerce (B.Com)',
        institute: 'Avadh University',
        year: '2020',
        score: '60%'),
    const EducationModel(
        degree: 'Higher Secondary (10+2)',
        institute: 'CBSE Board',
        year: '2016',
        score: '62.5%'),
    const EducationModel(
        degree: 'High School (10th)',
        institute: 'CBSE Board',
        year: '2014',
        score: '8.6 CGPA'),
  ];

  final marqueeSkills = [
    'Java', 'Kotlin', 'Flutter', 'Firebase', 'SQLite',
    'REST APIs', 'Android Studio', 'Material Design 3',
    'Google Play', 'Retrofit', 'Room DB', 'MVVM Architecture',
  ];

  // ── Contact Form Controllers & Submission State ──
  final contactFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isSubmittingContact = false.obs;
  final contactSubmittedSuccess = false.obs;

  void submitContactForm() async {
    if (contactFormKey.currentState?.validate() ?? false) {
      isSubmittingContact.value = true;
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 1200));
      isSubmittingContact.value = false;
      contactSubmittedSuccess.value = true;

      Get.snackbar(
        'Message Sent!',
        'Thank you for reaching out, Animesh will get back to you shortly.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isDark.value ? AppColors.darkBg2 : AppColors.lightAccent,
        colorText: isDark.value ? AppColors.accent : AppColors.lightAccentInk,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      );

      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();

      Future.delayed(const Duration(seconds: 5), () {
        contactSubmittedSuccess.value = false;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    _startTyping();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
