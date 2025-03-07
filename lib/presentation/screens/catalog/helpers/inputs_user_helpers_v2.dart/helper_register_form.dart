import 'package:finniu/infrastructure/datasources/forms_v2/register_form_v2_imp.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

pushDataForm(BuildContext context, DtoRegisterForm data, WidgetRef ref) {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: "Error al registrar",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
  }
  Future<RegisterUserV2Response> response =
      RegisterFormV2Impl(gqlClient!).saveCreateUserV2(data: data);
  response.then((value) {
    if (value.success) {
      ref.read(userProfileNotifierProvider.notifier).updateFields(
            nickName: data.nickName,
            password: data.password,
            email: data.email,
            phoneNumber: data.phoneNumber,
          );
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataSucces,
        parameters: {
          "screen": FirebaseScreen.registerV2,
          "succes": "register_succes",
        },
      );
      showSnackBarV2(
        context: context,
        title: "¡Registro exitoso!",
        message: "Tu cuenta ha sido creada correctamente",
        snackType: SnackType.success,
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, "/v2/send_code");
        ScaffoldMessenger.of(context).clearSnackBars();
        context.loaderOverlay.hide();
      });
    } else {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataError,
        parameters: {
          "screen": FirebaseScreen.registerV2,
          "error": "error_back",
        },
      );
      showSnackBarV2(
        context: context,
        title: "Error al registrar",
        message: value.messages[0].message,
        snackType: SnackType.error,
      );
      context.loaderOverlay.hide();
    }
  });
}
