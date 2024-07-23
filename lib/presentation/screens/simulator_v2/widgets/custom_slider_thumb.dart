import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageSliderThumbShape extends SliderComponentShape {
  final ui.Image image;
  final Color backgroundColor;

  ImageSliderThumbShape(
    this.image, {
    this.backgroundColor = Colors.white,
  }); // Default to white background

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(24.0, 24.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..filterQuality = FilterQuality.high;

    // Draw the circular background
    final double radius = image.width.toDouble() / 2;
    final Offset thumbOffset = center - Offset(radius, radius);
    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    // Draw the image at the center of the circle
    final Paint imagePaint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, thumbOffset, imagePaint);
  }
}
