enum PayOutStatus {
  pending,
  success,
  failed,
}

String getTitle(PayOutStatus status) {
  switch (status) {
    case PayOutStatus.failed:
      return '¡Tu pago ha rebotado!';
    case PayOutStatus.pending:
      return 'Tu pago está en proceso';
    case PayOutStatus.success:
      return '¡Tu pago se ha realizado con éxito!';
    default:
      return 'Tu pago ha fallado';
  }
}

class PayOutEntity {
  final String amount;
  final String currency;
  final String accountNumber;
  final String urlImageAccount;
  final PayOutStatus status;

  PayOutEntity({
    required this.status,
    required this.amount,
    required this.currency,
    required this.accountNumber,
    required this.urlImageAccount,
  });
}
