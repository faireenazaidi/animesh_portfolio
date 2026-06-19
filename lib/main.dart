import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/portfolio_binding.dart';
import 'theme/app_theme.dart';
import 'views/portfolio_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Animesh Pratap Singh — Android Developer',
      debugShowCheckedModeBanner: false,

      // ── Themes ──
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // default dark, toggled via controller

      // ── Initial route + binding ──
      initialRoute: '/',
      initialBinding: PortfolioBinding(), // registers PortfolioController
      getPages: [
        GetPage(
          name: '/',
          page: () => const PortfolioPage(),
          binding: PortfolioBinding(),
        ),
      ],

      // ── Scroll behaviour (web: no glow, draggable) ──
      scrollBehavior: _AppScrollBehavior(),
    );
  }
}

// Removes the Android overscroll glow and enables mouse drag scrolling on web
class _AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
