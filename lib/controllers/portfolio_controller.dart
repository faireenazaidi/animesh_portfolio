import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class PortfolioController extends GetxController {
  final isDark = true.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  final scrollController = ScrollController();
  final scrollProgress = 0.0.obs;
  final showBackToTop = false.obs;
  final heroKey = GlobalKey();
  final skillsKey = GlobalKey();
  final workKey = GlobalKey();
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

  final projects = <ProjectModel>[
    const ProjectModel(
      name: 'Digi Doctor',
      tagline: 'Medical records, appointments & video consultations.',
      description:
          'Patients manage medication, investigations, drug allergies, and admission history — plus appointment booking, video calls with doctors, online pharmacy and lab test booking. Built and designed solo.',
      stack: ['Java', 'Firebase', 'Android Studio'],
      link: 'https://play.google.com/store/apps/details?id=com.digidoctor.android',
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
      stack: ['Java', 'SQLite', 'Android Studio'],
      link: 'https://play.google.com/store/apps/details?id=com.nutritiontoday.android',
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
      stack: ['Java', 'REST APIs', 'Android Studio'],
      link: '',
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
      stack: ['Java', 'SQLite', 'Android Studio'],
      link: '',
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
      stack: ['Java', 'Firebase', 'Android Studio'],
      link: '',
      imageUrls: [
        'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=420&h=900&fit=crop&q=80',
        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=420&h=900&fit=crop&q=80',
      ],
      index: '05',
    ),
  ];

  final skills = <SkillModel>[
    const SkillModel(name: 'Java', percentage: 92),
    const SkillModel(name: 'Kotlin', percentage: 85),
    const SkillModel(name: 'Android Studio', percentage: 94),
    const SkillModel(name: 'Firebase', percentage: 88),
    const SkillModel(name: 'Flutter & Dart', percentage: 78),
    const SkillModel(name: 'SQLite', percentage: 84),
    const SkillModel(name: 'REST APIs', percentage: 86),
    const SkillModel(name: 'Material Design', percentage: 90),
  ];

  final education = <EducationModel>[
    const EducationModel(
        degree: 'GNIIT — Cloud Software Engineering',
        institute: 'NIIT, Lucknow',
        year: '2020',
        score: '95%'),
    const EducationModel(
        degree: 'B.Com',
        institute: 'Avadh University',
        year: '2020',
        score: '60%'),
    const EducationModel(
        degree: '10+2', institute: 'CBSE', year: '2016', score: '62.5%'),
    const EducationModel(
        degree: '10th', institute: 'CBSE', year: '2014', score: '8.6 CGPA'),
  ];

  final marqueeSkills = [
    'Java', 'Kotlin', 'Flutter', 'Firebase', 'SQLite',
    'REST APIs', 'Android Studio', 'Material Design',
    'Google Play', 'Retrofit', 'Room DB', 'MVVM',
  ];

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
    super.onClose();
  }
}
