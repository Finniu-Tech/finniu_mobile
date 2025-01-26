class LabelDetail {
  final String label;
  final int containerColorDark;
  final int containerColorLight;
  final int textColorDark;
  final int textColorLight;

  LabelDetail({
    required this.label,
    required this.containerColorDark,
    required this.containerColorLight,
    required this.textColorDark,
    required this.textColorLight,
  });
}

class StatusInvestmentEnum {
  static const String in_course = 'active';
  static const String finished = 'finished';
  static const String pending = 'pending';
  static const String in_process = 'in_process';

  static bool compare(String given, String targetStatus) {
    return given.toLowerCase() == targetStatus.toLowerCase();
  }

  static String getLabelForStatus(String status) {
    switch (status) {
      case StatusInvestmentEnum.in_course:
        return 'En curso';
      case StatusInvestmentEnum.in_process:
        return 'Por validar';
      case StatusInvestmentEnum.pending:
        return 'Pendiente';
      case StatusInvestmentEnum.finished:
        return 'Finalizada';
      default:
        return 'En curso';
    }
  }

  static LabelDetail getColorForStatus(String status) {
    switch (status) {
      case 'En curso':
        return LabelDetail(
          label: 'En curso',
          containerColorDark: 0xff55B63D,
          containerColorLight: 0xff55B63D,
          textColorDark: 0xffFFFFFF,
          textColorLight: 0xffFFFFFF,
        );
      case 'Por validar':
        return LabelDetail(
          label: 'Por validar',
          containerColorDark: 0xff0D3A5C,
          containerColorLight: 0xffA2E6FA,
          textColorDark: 0xffA2E6FA,
          textColorLight: 0xff0D3A5C,
        );
      case 'Pendiente':
        return LabelDetail(
          label: 'En curso',
          containerColorDark: 0xff55B63D,
          containerColorLight: 0xff55B63D,
          textColorDark: 0xffFFFFFF,
          textColorLight: 0xffFFFFFF,
        );
      case 'Finalizada':
        return LabelDetail(
          label: 'Finalizada',
          containerColorDark: 0xffAB6BFF,
          containerColorLight: 0xffAB6BFF,
          textColorDark: 0xffFFFFFF,
          textColorLight: 0xffFFFFFF,
        );
      default:
        return LabelDetail(
          label: 'Por validar',
          containerColorDark: 0xff0D3A5C,
          containerColorLight: 0xffA2E6FA,
          textColorDark: 0xffA2E6FA,
          textColorLight: 0xff0D3A5C,
        );
    }
  }
}

class ActionStatusEnum {
  static const String activeReInvestment = 'RE_INVERSION_ACTIVADA';
  static const String disabledReInvestment = 'RE_INVERSION_DESACTIVADA';
  static const String pendingReInvestment = 'RE_INVERSION_PENDIENTE';
  static const String defaultReInvestment = 'RE_INVERSION_DEFAULT';

  static bool compare(String given, String targetStatus) {
    return given.toLowerCase() == targetStatus.toLowerCase();
  }
}

class InvestmentRentabilityReport {
  final InvestmentRentabilityResumeEntity solesRentability;
  final InvestmentRentabilityResumeEntity dollarsRentability;

  InvestmentRentabilityReport({
    required this.solesRentability,
    required this.dollarsRentability,
  });
}

class InvestmentRentabilityResumeEntity {
  double totalAmount;
  double totalRentabilityAmount;
  int totalPlans;
  List<InvestmentRentabilityEntity>? investmentsInCourse;
  List<InvestmentRentabilityEntity>? investmentsFinished;
  List<InvestmentRentabilityEntity>? investmentsPending;

  InvestmentRentabilityResumeEntity({
    required this.totalAmount,
    required this.totalRentabilityAmount,
    required this.totalPlans,
    this.investmentsInCourse,
    this.investmentsFinished,
    this.investmentsPending,
  });

  int countTotalPlans() {
    int countInCourse = investmentsInCourse?.length ?? 0;
    int countInvesmentsFinished = investmentsFinished?.length ?? 0;
    int countInvestmentsPending = investmentsPending?.length ?? 0;
    return countInCourse + countInvesmentsFinished + countInvestmentsPending;
  }
}

// TODO verify statusinvestment values
class InvestmentRentabilityEntity {
  String uuid;
  DateTime createdAt;
  bool isActive;
  double amount;
  String? planName;
  String deadLineUuid;
  String deadLineName;
  int deadLineValue;
  bool? reinvestmentAvailable;
  String statusInvestment; // ACTIVE
  DateTime? startDateInvestment;
  DateTime? endDateInvestment;
  double rentabilityAmount;
  double rentabilityPercent;
  List<InvestmentCouponPartnerTagEntity?>? partnerCouponTag;
  InvestmentPartnerEntity? partner;
  bool isReInvestment = false;
  bool reInvestmentDisabled = false;
  String? actionStatus;

  InvestmentRentabilityEntity({
    required this.uuid,
    required this.createdAt,
    required this.isActive,
    required this.amount,
    required this.deadLineUuid,
    required this.deadLineName,
    required this.deadLineValue,
    this.reinvestmentAvailable,
    required this.statusInvestment,
    this.startDateInvestment,
    this.endDateInvestment,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    this.planName,
    this.partnerCouponTag,
    this.partner,
    this.isReInvestment = false,
    this.reInvestmentDisabled = false,
    this.actionStatus,
  });
}

class InvestmentCouponPartnerTagEntity {
  String partnerTag;
  String hexColor;

  InvestmentCouponPartnerTagEntity({
    required this.partnerTag,
    required this.hexColor,
  });
}

class InvestmentPartnerEntity {
  String partnerName;
  String? partnerLogoUrl;
  String? partnerHexColor;
  bool activateLogo;

  InvestmentPartnerEntity({
    required this.partnerName,
    this.partnerLogoUrl,
    this.partnerHexColor,
    required this.activateLogo,
  });
}
