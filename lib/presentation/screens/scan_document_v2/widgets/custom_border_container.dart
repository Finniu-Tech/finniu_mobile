import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBorderContainer extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final int borderColorDark;
  final int borderColorLight;
  final double height;

  const CustomBorderContainer({
    super.key,
    required this.child,
    required this.isDarkMode,
    required this.borderColorDark,
    required this.borderColorLight,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderPainter(
        isDarkMode: isDarkMode,
        borderColorDark: borderColorDark,
        borderColorLight: borderColorLight,
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final bool isDarkMode;
  final int borderColorDark;
  final int borderColorLight;

  BorderPainter({
    required this.isDarkMode,
    required this.borderColorDark,
    required this.borderColorLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Color borderColor =
        isDarkMode ? Color(borderColorDark) : Color(borderColorLight);

    const double radius = 13.0;
    const double step = 13.0;
    const double dashWidth = 7.0;

    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(radius),
        ),
      );

    for (PathMetric pathMetric in path.computeMetrics()) {
      for (double i = 0.0; i < pathMetric.length; i += step) {
        final Path extractPath = pathMetric.extractPath(i, i + dashWidth);
        canvas.drawPath(extractPath, paint..color = borderColor);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
