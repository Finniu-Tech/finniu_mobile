import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyColors {
  final Color solesColor;
  final Color dollarsColor;

  CurrencyColors({
    required this.solesColor,
    required this.dollarsColor,
  });
}

final currencyColorsProvider = Provider<CurrencyColors>((ref) {
  // Define los colores para modo día y modo noche
  const Color daySolesColor = Color(primaryDark);
  const Color dayDollarsColor = Color(whiteText);
  const Color nightSolesColor = Color(primaryDark);
  const Color nightDollarsColor = Color(whiteText);

  // Obtén el valor actual del modo oscuro desde tu provider existente
  final currentTheme = ref.watch(settingsNotifierProvider);
  final isDarkMode = currentTheme.isDarkMode;

  // Elige los colores según el modo actual (día o noche)
  final Color solesColor = isDarkMode ? nightSolesColor : daySolesColor;
  final Color dollarsColor = isDarkMode ? nightDollarsColor : dayDollarsColor;

  // Crea y devuelve la instancia de CurrencyColors con los colores seleccionados
  return CurrencyColors(
    solesColor: solesColor,
    dollarsColor: dollarsColor,
  );
});
