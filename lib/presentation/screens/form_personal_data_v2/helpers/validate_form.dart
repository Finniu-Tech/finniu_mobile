import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';

String? validateString({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 2) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "El ${field.toLowerCase()} debe tener al menos 1 caracter.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "$field inválido",
      message:
          "El ${field.toLowerCase()} no debe contener números ni caracteres especiales.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  return null;
}

String? validateAddress({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value.length < 2) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "El ${field.toLowerCase()} debe tener al menos 1 caracter.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  return null;
}

String? validateNumber({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  return null;
}

String? validateNumberMin({
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
  required isSoles,
  double? minValue,
}) {
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  final number = double.tryParse(value);
  if (number == null) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El valor debe ser un número válido.',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (minValue != null && number < minValue) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message:
          "El monto debe ser mayor o igual a ${isSoles ? 'S/.' : '\$/'}${minValue.toStringAsFixed(2)}",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  return null;
}

String? validateNumberDocument({
  required TypeDocumentEnum? typeDocument,
  required String field,
  required String? value,
  required BuildContext context,
  required ValueNotifier<bool> boolNotifier,
}) {
  if (typeDocument == null) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Por favor seleccione tipo de documento',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (value == null || value.isEmpty) {
    showSnackBarV2(
      context: context,
      title: "$field obligatorio",
      message: "Por favor, completa el ${field.toLowerCase()}.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.DNI && value.length != 8) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El DNI debe tener 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.CARNET && value.length < 8) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El Carnet de Extrajería debe tener 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.CARNET && value.length > 20) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El Carnet de Extrajería 20 debe tener mas de 20 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  return null;
}
