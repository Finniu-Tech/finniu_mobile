import 'package:finniu/infrastructure/datasources/forms_v2/location_form_v2_imp.dart';
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

pushLocationDataForm(
  BuildContext context,
  DtoLocationForm data,
  WidgetRef ref, {
  // String navigate = '/v2/form_about_me',
  String navigate = '/v2/form_job',
  bool isNavigate = false,
}) {
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
      LocationFormV2Imp(gqlClient!).saveLocationDataUserV2(data: data);
  response.then((value) {
    if (value.success) {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataSucces,
        parameters: {
          "screen": FirebaseScreen.formLocationV2,
          "success": "location_data_success",
        },
      );
      showSnackBarV2(
        context: context,
        title: "¡Guardado exitoso!",
        message: "Tus datos fueron guardados con éxito",
        snackType: SnackType.success,
      );
      ref.read(reloadUserProfileFutureProvider);
      Future.delayed(const Duration(seconds: 1), () {
        context.loaderOverlay.hide();
        isNavigate ? null : Navigator.pushNamed(context, navigate);
        ScaffoldMessenger.of(context).clearSnackBars();
      });
    } else {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.pushDataError,
        parameters: {
          "screen": FirebaseScreen.formLocationV2,
          "error": "location_data_error",
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
