import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';

void showNetworkWarning({required BuildContext context}) {
  showSnackBarV2(
    context: context,
    title: "Conéctate a internet",
    message: "No tienes internet, comprueba tu conexión",
    snackType: SnackType.info,
  );
}
