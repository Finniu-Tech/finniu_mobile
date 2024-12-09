class HomeUserInvest {
  final AllInvestment? investmentInSoles;
  final AllInvestment? investmentInDolares;

  HomeUserInvest({
    required this.investmentInSoles,
    required this.investmentInDolares,
  });

  factory HomeUserInvest.fromJson(Map<String, dynamic> json) {
    return HomeUserInvest(
      investmentInSoles: (json['invesmentInSoles'] as List<dynamic>?)
          ?.map((e) => AllInvestment.fromJson(e))
          .toList()
          .firstOrNull,
      investmentInDolares: (json['invesmentInDolares'] as List<dynamic>?)
          ?.map((e) => AllInvestment.fromJson(e))
          .toList()
          .firstOrNull,
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
  final String? totalBalanceRentability;
  final int? capitalInCourse;
  final String? totalBalanceRentabilityIncreased;

  AllInvestment({
    required this.countPlanesActive,
    required this.totalBalanceRentability,
    required this.capitalInCourse,
    required this.totalBalanceRentabilityIncreased,
  });

  factory AllInvestment.fromJson(Map<String, dynamic> json) {
    return AllInvestment(
      countPlanesActive: json['countPlanesActive'] as int?,
      totalBalanceRentability: json['totalBalanceRentability'] as String?,
      capitalInCourse: json['capitalInCourse'] as int?,
      totalBalanceRentabilityIncreased:
          json['totalBalanceRentabilityIncreased'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countPlanesActive': countPlanesActive,
      'totalBalanceRentability': totalBalanceRentability,
      'capitalInCourse': capitalInCourse,
      'totalBalanceRentabilityIncreased': totalBalanceRentabilityIncreased,
    };
  }
}

extension ListExtension<E> on List<E> {
  E? get firstOrNull => isNotEmpty ? first : null;
}