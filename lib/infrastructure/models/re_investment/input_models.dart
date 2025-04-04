import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';

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

class OriginFunds {
  final OriginFoundsEnum originFundsEnum;
  final String? otherText;

  OriginFunds({required this.originFundsEnum, this.otherText});

  Map<String, dynamic> toJson() => {
        'originFundsEnum': originFundsEnum.toString().split('.').last,
        'otherText': otherText,
      };
}

OriginFunds mapToOriginFunds(String? category, [String? otherText]) {
  switch (category) {
    case 'SALARIOS_Y_SUELDOS':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.SALARIO);
    case 'AHORROS_PERSONALES':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.AHORROS);
    case 'VENTA_DE_BIENES':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.VENTA_BIENES);
    case 'INVERSIONES':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.INVERSIONES);
    case 'HERENCIA':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.HERENCIA);
    case 'PRESTAMOS':
      return OriginFunds(originFundsEnum: OriginFoundsEnum.PRESTAMOS);
    case 'OTROS':
      return OriginFunds(
        originFundsEnum: OriginFoundsEnum.OTROS,
        otherText: otherText,
      );
    default:
      return OriginFunds(
        originFundsEnum: OriginFoundsEnum.OTROS,
        otherText: "Otros",
      );
  }
}

enum OriginFoundsEnum {
  SALARIO,
  AHORROS,
  VENTA_BIENES,
  INVERSIONES,
  HERENCIA,
  PRESTAMOS,
  OTROS,
}

class OriginFoundsUtil {
  static final Map<OriginFoundsEnum, String> _readableNames = {
    OriginFoundsEnum.SALARIO: 'Salario',
    OriginFoundsEnum.AHORROS: 'Ahorros',
    OriginFoundsEnum.VENTA_BIENES: 'Venta Bienes',
    OriginFoundsEnum.INVERSIONES: 'Inversiones',
    OriginFoundsEnum.HERENCIA: 'Herencia',
    OriginFoundsEnum.PRESTAMOS: 'Préstamos',
    OriginFoundsEnum.OTROS: 'Otros',
  };

  static String toReadableName(OriginFoundsEnum originFound) {
    return _readableNames[originFound] ?? '';
  }

  static OriginFoundsEnum fromReadableName(String readableName) {
    return _readableNames.entries
        .firstWhere(
          (entry) => entry.value == readableName,
          orElse: () => const MapEntry(OriginFoundsEnum.OTROS, ''),
        )
        .key;
  }

  static List<String> getReadableNames() {
    return _readableNames.values.toList();
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

class CreateReInvestmentParams {
  final String preInvestmentUUID;
  final String finalAmount;
  final String currency;
  final String deadlineUUID;
  final String? coupon;
  final OriginFunds originFounds;
  final String typeReinvestment;
  final String? bankAccountSender;
  final String? bankAccountReceiver;

  CreateReInvestmentParams({
    required this.preInvestmentUUID,
    required this.finalAmount,
    required this.currency,
    required this.deadlineUUID,
    this.coupon,
    required this.originFounds,
    required this.typeReinvestment,
    this.bankAccountReceiver,
    this.bankAccountSender,
  });

  Map<String, dynamic> toJson() => {
        'preInvestmentUUID': preInvestmentUUID,
        'finalAmount': finalAmount,
        'currency': currency,
        'deadlineUUID': deadlineUUID,
        'coupon': coupon,
        'originFounds': originFounds.toJson(),
        'typeReinvestment': typeReinvestment,
        'bankAccountSenderUUID': bankAccountSender,
        'bankAccountReceiverUUID': bankAccountReceiver,
      };
}

class ReInvestmentStep2Params {
  final PlanEntity plan;
  final ReInvestmentEntity reinvestment;
  final PlanSimulation resultCalculator;

  ReInvestmentStep2Params({
    required this.plan,
    required this.reinvestment,
    required this.resultCalculator,
  });
}

class UpdateReInvestmentParams {
  final String preInvestmentUUID;
  final bool userReadContract;
  final List<String>? files;
  final String? bankAccountSender;
  final String? bankAccountReceiver;

  UpdateReInvestmentParams({
    required this.preInvestmentUUID,
    required this.userReadContract,
    this.files,
    this.bankAccountSender,
    this.bankAccountReceiver,
  });

  Map<String, dynamic> toJson() => {
        'preInvestmentUUID': preInvestmentUUID,
        'userReadContract': userReadContract,
        'files': files,
        'bankAccountSenderUUID': bankAccountSender,
        'bankAccountReceiverUUID': bankAccountReceiver,
      };
}

class SetBankAccountUserParams {
  final String reInvestmentUUID;
  final String bankAccountReceiver;

  SetBankAccountUserParams({
    required this.reInvestmentUUID,
    required this.bankAccountReceiver,
  });
}
