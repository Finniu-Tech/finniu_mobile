import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageSliderThumbShape extends SliderComponentShape {
  final ui.Image image;
  final Color backgroundColor;

  ImageSliderThumbShape(
    this.image, {
    this.backgroundColor = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(24.0, 24.0);
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

    final double radius = image.width.toDouble() / 2;
    final Offset thumbOffset = center - Offset(radius, radius);
    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    final Paint imagePaint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, thumbOffset, imagePaint);
  }
}

class EmojiSliderThumbShape extends SliderComponentShape {
  final String emoji;
  final Color backgroundColor;
  final TextStyle textStyle;

  EmojiSliderThumbShape(
    this.emoji, {
    this.backgroundColor = Colors.white,
    this.textStyle = const TextStyle(fontSize: 24.0),
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(35.0, 35.0);
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

    final double radius = getPreferredSize(true, false).width / 2;
    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: textStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    final Offset textOffset =
        center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }
}
