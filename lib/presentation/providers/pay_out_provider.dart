import 'package:finniu/domain/entities/pay_out_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final payOutProvider =
    FutureProvider.autoDispose.family<PayOutEntity, String>((ref, id) async {
  try {
    await Future.delayed(const Duration(seconds: 2));

    return PayOutEntity(
      amount: 'S/ 1,000.00',
      currency: 'Cuenta soles',
      accountNumber: '122009301103',
      urlImageAccount:
          'https://finniu-statics-qa.s3.amazonaws.com/finniu/images/bank/f484570d/pichincha.png',
      status: PayOutStatus.success,
    );
  } catch (e) {
    return PayOutEntity(
      amount: 'S/ 0.00',
      currency: 'Cuenta soles',
      accountNumber: '----------',
      urlImageAccount: '',
      status: PayOutStatus.failed,
    );
  }
});
