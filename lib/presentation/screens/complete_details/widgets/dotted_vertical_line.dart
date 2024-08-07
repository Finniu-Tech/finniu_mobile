import 'package:flutter/material.dart';

class DottedVerticalLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final List<Color> gradientColors;

  const DottedVerticalLine({
    super.key,
    required this.height,
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(dashWidth, height),
      painter: DottedLinePainter(
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        dashSpace: dashSpace,
        gradientColors: gradientColors,
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final List<Color> gradientColors;

  DottedLinePainter({
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = dashWidth
      ..shader = LinearGradient(
        colors: gradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, dashWidth, size.height));

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
