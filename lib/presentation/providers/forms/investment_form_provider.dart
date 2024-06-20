import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/investment/investment_form_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormNotifier extends StateNotifier<InvestmentFormData> {
  FormNotifier()
      : super(
          InvestmentFormData(
            amount: 0,
            uuidBank: null,
            uuidDeadline: 0,
            uuidPlan: '',
            currency: '',
            coupon: '',
          ),
        );

  void updateAmount(int amount) {
    state = state.copyWith(amount: amount);
  }

  void updateUuidBank(BankAccount? uuidBank) {
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

final formNotifierProvider =
    StateNotifierProvider<FormNotifier, InvestmentFormData>((ref) {
  return FormNotifier();
});
