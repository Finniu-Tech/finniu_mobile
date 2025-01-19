import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void navigateToNext({
  required bool success,
  required WidgetRef ref,
  required BuildContext context,
  required String uuid,
  required String amount,
  required ProductData productData,
}) {
  print('navegar a siguiente ${productData.toJson()}');
  if (success) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/v2/investment/step-2',
      (route) => false,
      arguments: {'preInvestmentUUID': uuid, 'amount': amount, 'productData': productData},
    );
  } else {
    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
      eventName: FirebaseAnalyticsEvents.pushDataError,
      parameters: {
        "screen": FirebaseScreen.investmentStep1V2,
        "event": "save_pre_investment_error",
      },
    );
    showSnackBarV2(
      context: context,
      title: "Error interno",
      message: 'Hubo un problema, asegúrate de haber completado todos los campos',
      snackType: SnackType.error,
    );
  }
}
