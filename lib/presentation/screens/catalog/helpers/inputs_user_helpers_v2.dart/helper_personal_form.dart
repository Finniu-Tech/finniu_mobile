import 'package:finniu/infrastructure/datasources/forms_v2/personal_form_v2_imp.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
// import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

pushPersonalDataForm(
  BuildContext context,
  DtoPersonalForm data,
  WidgetRef ref, {
  String navigate = '/v2/form_location',
  bool isEdit = false,
}) {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: isEdit ? "Error al registrar" : "Error al editar",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
  }
  Future<RegisterUserV2Response> response =
      PersonalFormV2Imp(gqlClient!).savePersonalDataUserV2(data: data);
  response.then((value) {
    if (value.success) {
      showSnackBarV2(
        context: context,
        title: "¡Guardado exitoso!",
        message: "Tus datos fueron guardados con éxito",
        snackType: SnackType.success,
      );

      // ref.invalidate(userProfileFutureProvider);

      context.loaderOverlay.hide();
      Navigator.pushNamed(context, navigate);
    } else {
      showSnackBarV2(
        context: context,
        title: isEdit ? "Error al registrar" : "Error al editar",
        message: value.messages[0].message,
        snackType: SnackType.error,
      );

      context.loaderOverlay.hide();
    }
  });
}
