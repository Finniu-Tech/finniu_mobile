import 'package:finniu/infrastructure/models/investment/investment_form_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormNotifier extends StateNotifier<InvestmentFormData> {
  FormNotifier()
      : super(
          InvestmentFormData(
            amount: 0,
            uuidBank: '',
            uuidDeadline: 0,
            uuidPlan: '',
            currency: '',
            coupon: '',
          ),
        );

  void updateAmount(int amount) {
    state = state.copyWith(amount: amount);
  }

  void updateUuidBank(String uuidBank) {
    state = state.copyWith(uuidBank: uuidBank);
  }

  void updateUuidDeadline(int uuidDeadline) {
    state = state.copyWith(uuidDeadline: uuidDeadline);
  }

  void updateUuidPlan(String uuidPlan) {
    state = state.copyWith(uuidPlan: uuidPlan);
  }

  void updateCurrency(String currency) {
    state = state.copyWith(currency: currency);
  }

  void updateCoupon(String coupon) {
    state = state.copyWith(coupon: coupon);
  }
}

// Crear un StateNotifierProvider para el FormNotifier
final formNotifierProvider =
    StateNotifierProvider<FormNotifier, InvestmentFormData>((ref) {
  return FormNotifier();
});
