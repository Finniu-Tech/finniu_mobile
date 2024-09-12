import 'package:finniu/infrastructure/datasources/forms_v2/about_me_form_v2_imp.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

pushAboutMeDataForm(
  BuildContext context,
  DtoAboutMeForm data,
  WidgetRef ref,
) {
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
      AboutMeFormV2Imp(gqlClient!).saveAboutMeDataUserV2(data: data);
  ref.read(reloadUserProfileFutureProvider);
  response.then((value) {
    if (value.success) {
      showSnackBarV2(
        context: context,
        title: "Registro exitoso",
        message: value.messages[0].message,
        snackType: SnackType.success,
      );

      Future.delayed(const Duration(seconds: 1), () {
        context.loaderOverlay.hide();
        Navigator.pushNamed(context, '/home_v2');
        ScaffoldMessenger.of(context).clearSnackBars();
      });
    } else {
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
