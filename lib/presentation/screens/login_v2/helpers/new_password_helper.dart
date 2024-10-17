import 'package:finniu/presentation/providers/recovery_password_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/modal_new_password.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void resetPassword({
  required BuildContext context,
  required WidgetRef ref,
  required String newPassword,
}) async {
  final status = await ref.read(
    setNewPasswordFutureProvider(newPassword).future,
  );
  if (status == true) {
    ref.read(userProfileNotifierProvider.notifier).setPassword(newPassword);
    const SnackBar(
      content: Text('Contraseña cambiada con éxito'),
    );
    showSnackBarV2(
      context: context,
      title: "Contraseña cambiada con ≠!",
      message: 'Contraseña cambiada con éxito!',
      snackType: SnackType.success,
    );

    await Future.delayed(const Duration(seconds: 1));
    context.loaderOverlay.hide();
    modalNewPassword(context);
  } else {
    context.loaderOverlay.hide();
    showSnackBarV2(
      context: context,
      title: "Error al cambiar la contraseña",
      message: 'No se pudo cambiar la contraseña',
      snackType: SnackType.error,
    );
  }
}
