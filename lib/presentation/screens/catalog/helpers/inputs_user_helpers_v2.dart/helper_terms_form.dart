import 'package:finniu/infrastructure/datasources/forms_v2/legal_terms_form_v2_imp.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_form_dto.dart';
import 'package:finniu/infrastructure/models/user_profile_v2/profile_response.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

pushLegalTermsDataForm(
    BuildContext context, DtoLegalTermsForm data, WidgetRef ref) {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    CustomSnackbar.show(
      context,
      "No se pudo conectar con el servidor",
      'error',
    );
  }
  Future<RegisterUserV2Response> response =
      LegalTermsFormV2Imp(gqlClient!).saveLegalTermsDataUserV2(data: data);
  response.then((value) {
    if (value.success) {
      CustomSnackbar.show(
        context,
        value.messages[0].message,
        'success',
      );
      context.loaderOverlay.hide();
      Navigator.pushNamed(context, '/v2/form_about_me');
    } else {
      CustomSnackbar.show(
        context,
        value.messages[0].message,
        'error',
      );
      context.loaderOverlay.hide();
    }
  });
}
