import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';

String? validatePassword({
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  final RegExp hasUppercase = RegExp(r'[A-Z]');
  final RegExp hasDigits = RegExp(r'[0-9]');
  final RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "Password incorrecto",
      message: 'Por favor ingresa tu contraseña',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 8) {
    showSnackBarV2(
      context: context,
      title: "Password incorrecto",
      message: 'Debe tener al menos 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!hasUppercase.hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Password incorrecto",
      message: 'Debe contener al menos una mayúscula',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!hasDigits.hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Password incorrecto",
      message: 'Debe contener al menos un número',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!hasSpecialCharacters.hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Password incorrecto",
      message: 'Debe contener al menos un carácter especial',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  boolNotifier.value = false;
  return null;
}

String? validateEmail({
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "Email incorrecto",
      message: 'Por favor ingresa tu correo electrónico',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Email incorrecto",
      message: 'El email escrito es inválido, falta el “@”',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}

String? validatePhone({
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "Telefono incorrecto",
      message: "Por favor, completa el telefono.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Telefono incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 9) {
    showSnackBarV2(
      context: context,
      title: "Telefono incorrecto",
      message: 'El nómero debe tener 9 digitos',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length > 13) {
    showSnackBarV2(
      context: context,
      title: "Telefono incorrecto",
      message: 'El nómero no debe superar los 13 digitos',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}

String? validateName({
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "Nombre obligatorio",
      message: "Por favor, completa el nombre.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 2) {
    showSnackBarV2(
      context: context,
      title: "Nombre obligatorio",
      message: "El nombre debe tener al menos 1 caracter.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "Nombre inválido",
      message: "El nombre no debe contener números ni caracteres especiales.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}

String? validateConfirmPassword({
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
  required String password,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "Confirmacion password incorrecto",
      message: "Por favor, completa la confirmación del password.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value != password) {
    showSnackBarV2(
      context: context,
      title: "Confirmacion password incorrecto",
      message: "Las contraseñas no coinciden.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}
