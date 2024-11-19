import 'package:finniu/infrastructure/datasources/forms_v2/add_account_bank.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void createBankAccountV2({
  required BuildContext context,
  required CreateBankAccountInput input,
  required WidgetRef ref,
}) async {
  final gqlClient = ref.watch(gqlClientProvider).value;

  if (gqlClient == null) {
    showSnackBarV2(
      context: context,
      title: "Error al registrar",
      message: "No se pudo conectar con el servidor",
      snackType: SnackType.error,
    );
    return;
  }
  try {
    final response = await AddAccountBankImp(gqlClient).addAccountDataUserV2(
      input: input,
    );
    if (response.success) {
      ref.invalidate(bankAccountFutureProvider);
      ref.read(boolCreatedNewBankAccountProvider.notifier).state = true;

      showSnackBarV2(
        context: context,
        title: "Cuenta guardada correctamente",
        message: "Cuenta guardada correctamente",
        snackType: SnackType.success,
      );
      Navigator.pop(context);
    } else {
      final errorMessage = response.messages.isNotEmpty
          ? response.messages.first.message
          : "Verifique los datos e intente nuevamente";

      showSnackBarV2(
        context: context,
        title: "Error al guardar la cuenta",
        message: errorMessage,
        snackType: SnackType.error,
      );
    }
  } catch (e) {
    showSnackBarV2(
      context: context,
      title: "Error al guardar la cuenta",
      message: "Ocurrió un error inesperado. Intente nuevamente.",
      snackType: SnackType.error,
    );
  } finally {
    context.loaderOverlay.hide();
  }
}
