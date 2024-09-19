import 'package:finniu/infrastructure/datasources/email_reset_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/config_v2/widgets/show_change_password.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void emailReset(BuildContext context, WidgetRef ref) async {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: "Error al registrar",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
    context.loaderOverlay.hide();
    return;
  }

  Future<bool> response = EmailResetImp(gqlClient).emailReset();

  response.then((value) {
    if (value) {
      showSnackBarV2(
        context: context,
        title: "Email enviado con exito",
        message: "Se a enviado un Email de recuperación",
        snackType: SnackType.success,
      );
      context.loaderOverlay.hide();
      showChangePassword(context);
    } else {
      showSnackBarV2(
        context: context,
        title: "Error al enviar Email",
        message: "No se pudo enviar el Email de recuperación",
        snackType: SnackType.error,
      );
      context.loaderOverlay.hide();
    }
  });
}
