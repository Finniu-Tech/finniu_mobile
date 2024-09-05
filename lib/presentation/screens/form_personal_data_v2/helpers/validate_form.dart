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
      title: "${field.toLowerCase()} obligatorio",
      message: "El ${field.toLowerCase()} debe tener al menos 1 caracter.",
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
    showSnackBarV2(
      context: context,
      title: "${field.toLowerCase()} inválido",
      message:
          "El ${field.toLowerCase()} no debe contener números ni caracteres especiales.",
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
      title: "${field.toLowerCase()} incorrecto",
      message: 'Solo puedes usar números',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }

  boolNotifier.value = true;
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
  if (typeDocument == TypeDocumentEnum.CARNET_EXTRAJERIA && value.length < 8) {
    showSnackBarV2(
      context: context,
      title: "$field incorrecto",
      message: 'El Carnet de Extrajería debe tener 8 caracteres',
      snackType: SnackType.warning,
    );
    boolNotifier.value = true;
    return null;
  }
  if (typeDocument == TypeDocumentEnum.CARNET_EXTRAJERIA && value.length > 20) {
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
