String mapReason(String reason) {
  switch (reason) {
    case 'Ya completé mi meta':
      return 'GOAL_ACCOMPLISHED';
    case 'Necesito mi dinero':
      return 'NEED_MY_MONEY';
    case 'Me han ofrecido mejor rentabilidad':
      return 'BETTER_RENTABILITY';
    case 'Percibo mucho riesgo':
      return 'TOO_MUCH_RISK';
    case 'Otros':
      return 'OTHER';
    default:
      return '';
  }
}

String mapTypeAccount(String typeAccount) {
  switch (typeAccount) {
    case 'Ahorros':
      return 'AHORROS';
    case 'Corriente':
      return 'CORRIENTE';
    case 'Mancomunada':
      return 'MANCOMUNADA';

    default:
      return '';
  }
}

class RejectReInvestmentParams {
  final String preInvestmentUUID;
  final String rejectMotivation;
  final String? textRejected;

  RejectReInvestmentParams({
    required this.preInvestmentUUID,
    required this.rejectMotivation,
    this.textRejected,
  });
}
