import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import '../../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class MarqueeSection extends StatelessWidget {
  const MarqueeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PortfolioController>();
    return SizedBox(
      height: 52,
      child: _InfiniteMarquee(items: c.marqueeSkills),
    );
  }
}

class _InfiniteMarquee extends StatefulWidget {
  final List<String> items;
  const _InfiniteMarquee({required this.items});

  @override
  State<_InfiniteMarquee> createState() => _InfiniteMarqueeState();
}

class _InfiniteMarqueeState extends State<_InfiniteMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
    _anim = Tween<double>(begin: 0, end: 1).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final all = [...widget.items, ...widget.items];
    return ClipRect(
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          return CustomPaint(
            painter: _MarqueePainter(
              progress: _anim.value,
              items: all,
              textColor: ink3(context),
              accentColor: AppColors.accent,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _MarqueePainter extends CustomPainter {
  final double progress;
  final List<String> items;
  final Color textColor;
  final Color accentColor;

  _MarqueePainter({
    required this.progress,
    required this.items,
    required this.textColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const itemWidth = 160.0;
    final totalWidth = itemWidth * items.length;
    final offset = -(progress * totalWidth / 2);

    for (int i = 0; i < items.length; i++) {
      final x = (i * itemWidth + offset) % (totalWidth / 2);
      final dx = x < -itemWidth ? x + totalWidth / 2 : x;

      // Dot
      final dotPaint = Paint()..color = accentColor;
      canvas.drawCircle(Offset(dx + 8, size.height / 2), 4, dotPaint);

      // Text
      final tp = TextPainter(
        text: TextSpan(
          text: items[i],
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 13,
            color: textColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(dx + 22, (size.height - tp.height) / 2));
    }
  }

  @override
  bool shouldRepaint(_MarqueePainter old) => old.progress != progress;
}
