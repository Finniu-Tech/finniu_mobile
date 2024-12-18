class HomeUserInvest {
  final AllInvestment? investmentInSoles;
  final AllInvestment? investmentInDolares;

  HomeUserInvest({
    required this.investmentInSoles,
    required this.investmentInDolares,
  });

  factory HomeUserInvest.fromJson(Map<String, dynamic> json) {
    return HomeUserInvest(
      investmentInSoles:
          (json['invesmentInSoles'] as List<dynamic>?)?.map((e) => AllInvestment.fromJson(e)).toList().firstOrNull,
      investmentInDolares:
          (json['invesmentInDolares'] as List<dynamic>?)?.map((e) => AllInvestment.fromJson(e)).toList().firstOrNull,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invesmentInSoles': investmentInSoles?.toJson(),
      'invesmentInDolares': investmentInDolares?.toJson(),
    };
  }
}

class AllInvestment {
  final int? countPlanesActive;

  final int? capitalInCourse;

  final String? totalBalanceRentabilityIncreased;
  final String? averageProfitability;
  final String? percentageProfitabilityIncreaseMonthly;

  AllInvestment({
    required this.countPlanesActive,
    required this.averageProfitability,
    required this.capitalInCourse,
    required this.totalBalanceRentabilityIncreased,
    required this.percentageProfitabilityIncreaseMonthly,
  });

  factory AllInvestment.fromJson(Map<String, dynamic> json) {
    return AllInvestment(
      averageProfitability: json['averageProfitability'] as String?,
      countPlanesActive: json['countPlanesActive'] as int?,
      capitalInCourse: json['capitalInCourse'] as int?,
      totalBalanceRentabilityIncreased: json['totalBalanceRentabilityIncreased'] as String?,
      percentageProfitabilityIncreaseMonthly: json['totalPercentPerMonth'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countPlanesActive': countPlanesActive,
      'capitalInCourse': capitalInCourse,
      'totalBalanceRentabilityIncreased': totalBalanceRentabilityIncreased,
    };
  }
}

extension ListExtension<E> on List<E> {
  E? get firstOrNull => isNotEmpty ? first : null;
}

final AllInvestment investmentErrorInSoles = AllInvestment(
  countPlanesActive: 0,
  averageProfitability: "0",
  capitalInCourse: 0,
  totalBalanceRentabilityIncreased: "0",
  percentageProfitabilityIncreaseMonthly: "0",
);

final AllInvestment investmentErrorInDolares = AllInvestment(
  countPlanesActive: 0,
  averageProfitability: "0",
  capitalInCourse: 0,
  totalBalanceRentabilityIncreased: "0",
  percentageProfitabilityIncreaseMonthly: "0",
);

final HomeUserInvest homeUserErrorInvest = HomeUserInvest(
  investmentInSoles: investmentErrorInSoles,
  investmentInDolares: investmentErrorInDolares,
);
