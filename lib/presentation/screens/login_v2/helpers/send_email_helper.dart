import 'package:finniu/presentation/providers/recovery_password_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/login_v2/widgets/modal_send_code_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void sendEmailRecovery({
  required BuildContext context,
  required WidgetRef ref,
  required String email,
}) async {
  final status = await ref.watch(
    recoveryPasswordFutureProvider(email).future,
  );
  if (status == true) {
    ref.read(userProfileNotifierProvider.notifier).setEmail(email);
    sendEmailRecoveryPasswordModalV2(context, ref);
  } else {
    showSnackBarV2(
      context: context,
      title: "Error al enviar correo",
      message: 'El correo ingresado no existe',
      snackType: SnackType.error,
    );
  }
}