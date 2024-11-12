import 'dart:async';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<List<SnackBarContainerV2>> createBankAccount({
  required BuildContext context,
  required CreateBankAccountInput input,
  required WidgetRef ref,
}) async {
  List<SnackBarContainerV2> result = [];
  final Completer<List<SnackBarContainerV2>> completer = Completer();

  ref.read(createBankAccountProvider(input).future).then(
    (response) {
      context.loaderOverlay.hide();
      ref.invalidate(bankAccountFutureProvider);

      if (response.success) {
        showSnackBarV2(
          context: context,
          title: "Cuenta guardada correctamente",
          message: "Cuenta guardada correctamente",
          snackType: SnackType.success,
        );
        ref.read(boolCreatedNewBankAccountProvider.notifier).state = true;
      } else {
        result.add(
          const SnackBarContainerV2(
            title: "Error al guardar la cuenta",
            message: "Verifique los datos e intente nuevamente",
            snackType: SnackType.error,
          ),
        );
      }

      completer.complete(result);
    },
  ).catchError((error) {
    context.loaderOverlay.hide();
    completer.completeError(error);
  });

  return completer.future;
}
