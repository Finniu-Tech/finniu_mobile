import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

SnackBar customSnackBar = SnackBar(
  backgroundColor: const Color(primaryLight),
  action: SnackBarAction(
    textColor: const Color(primaryDark),
    label: 'Cerrar',
    onPressed: () {},
  ),
  content: const Text(
    'No se pudo validar el código de verificación',
    textAlign: TextAlign.center,
  ),
  duration: const Duration(milliseconds: 3000),
  width: 280, // Width of the SnackBar.
  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);
