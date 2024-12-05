import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void couponFinish({
  required BuildContext context,
  required PlanSimulation? plan,
  required WidgetRef ref,
  required String coupon,
  required TextEditingController couponController,
}) {
  {
    if (plan?.error == null) {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.addCoupon,
        parameters: {
          "screen": FirebaseScreen.investmentStep1V2,
          'cupon_applied': true.toString(),
        },
      );
      showSnackBarV2(
        context: context,
        title: "Cupón aplicado",
        message: 'Cupón aplicado correctamente',
        snackType: SnackType.success,
      );
    } else {
      couponController.clear();
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.addCoupon,
        parameters: {
          "screen": FirebaseScreen.investmentStep1V2,
          'cupon_applied': false.toString(),
        },
      );
      showSnackBarV2(
        context: context,
        title: "Error al aplicar cupón",
        message: plan?.error ?? 'Hubo un problema, intenta nuevamente',
        snackType: SnackType.error,
      );
    }
  }
}
