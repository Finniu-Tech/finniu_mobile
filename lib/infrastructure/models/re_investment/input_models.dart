import 'package:finniu/presentation/screens/calendar.dart';

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

enum OriginFounds {
  SALARIO,
  AHORROS,
  VENTA_BIENES,
  INVERSIONES,
  HERENCIA,
  PRESTAMOS,
  OTROS,
}

class OriginFoundsUtil {
  static Map<OriginFounds, String> _readableNames = {
    OriginFounds.SALARIO: 'Salario',
    OriginFounds.AHORROS: 'Ahorros',
    OriginFounds.VENTA_BIENES: 'Venta Bienes',
    OriginFounds.INVERSIONES: 'Inversiones',
    OriginFounds.HERENCIA: 'Herencia',
    OriginFounds.PRESTAMOS: 'Préstamos',
    OriginFounds.OTROS: 'Otros',
  };

  static String toReadableName(OriginFounds originFound) {
    return _readableNames[originFound] ?? '';
  }

  static OriginFounds? fromReadableName(String readableName) {
    return _readableNames.entries
        .firstWhere((entry) => entry.value == readableName, orElse: () => const MapEntry(OriginFounds.OTROS, ''))
        .key;
  }

  static List<String> getReadableNames() {
    return _readableNames.values.toList();
  }

  static String toBackendValue(OriginFounds originFound) {
    return originFound.toString().split('.').last;
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
