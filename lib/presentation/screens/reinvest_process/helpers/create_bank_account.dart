import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void createBankAccount({
  required BuildContext context,
  required CreateBankAccountInput input,
  required WidgetRef ref,
}) {
  ref.read(createBankAccountProvider(input).future).then(
    (response) {
      if (response.success) {
        context.loaderOverlay.hide();
        ref.invalidate(bankAccountFutureProvider);
        showSnackBarV2(
          context: context,
          title: "Cuenta guardada correctamente",
          message: "Cuenta guardada correctamente",
          snackType: SnackType.success,
        );

        ref.read(boolCreatedNewBankAccountProvider.notifier).state = true;
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      } else {
        context.loaderOverlay.hide();
        ref.invalidate(bankAccountFutureProvider);
        showSnackBarV2(
          context: context,
          title: "Error al guardar la cuenta",
          message: "Verifique los datos e intente nuevamente",
          snackType: SnackType.error,
        );
      }
    },
  );
}
