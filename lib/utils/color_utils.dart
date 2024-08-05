import 'package:flutter/material.dart';

Color adjustColor(Color color, {double saturationFactor = 1.2, double lightnessFactor = 0.9}) {
  HSLColor hslColor = HSLColor.fromColor(color);
  double newSaturation = (hslColor.saturation * saturationFactor).clamp(0.0, 1.0);
  double newLightness = (hslColor.lightness * lightnessFactor).clamp(0.0, 1.0);
  HSLColor adjustedHslColor = hslColor.withSaturation(newSaturation).withLightness(newLightness);
  return adjustedHslColor.toColor();
}
