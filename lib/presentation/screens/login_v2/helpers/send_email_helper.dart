import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
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
    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
      eventName: FirebaseAnalyticsEvents.pushDataSucces,
      parameters: {
        "screen": "/v2/form_forgot",
        "success": "push_data_succes",
        "show_modal": "modal_send_code",
      },
    );
    ref.read(userProfileNotifierProvider.notifier).setEmail(email);
    sendEmailRecoveryPasswordModalV2(context, ref);
  } else {
    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
      eventName: FirebaseAnalyticsEvents.pushDataError,
      parameters: {
        "screen": "/v2/form_forgot",
        "error": "push_data_error",
      },
    );
    showSnackBarV2(
      context: context,
      title: "Error al enviar correo",
      message: 'El correo ingresado no existe',
      snackType: SnackType.error,
    );
  }
}
