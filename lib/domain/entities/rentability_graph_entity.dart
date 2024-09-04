class RentabilityGraphicEntity {
  String month;
  String? date;
  String amountPoint;
  dynamic typename;

  RentabilityGraphicEntity({
    required this.month,
    required this.amountPoint,
    this.date,
    this.typename,
  });

  RentabilityGraphicEntity copyWith({
    String? month,
    String? amountPoint,
    dynamic typename,
    String? date,
  }) {
    return RentabilityGraphicEntity(
      month: month ?? this.month,
      amountPoint: amountPoint ?? this.amountPoint,
      typename: typename ?? this.typename,
      date: date,
    );
  }

  factory RentabilityGraphicEntity.fromJson(Map<String, dynamic> json) {
    return RentabilityGraphicEntity(
      month: json['month'],
      amountPoint: json['amountPoint'].toString(),
      typename: json['__typename'],
      date: json['date'],
    );
  }
}

class RentabilityGraphicResponseAPI {
  List<RentabilityGraphicEntity>? rentabilityInPen;
  List<RentabilityGraphicEntity>? rentabilityInUsd;
  String? error;
  bool? success;

  RentabilityGraphicResponseAPI({
    this.rentabilityInPen,
    this.rentabilityInUsd,
    this.error,
    this.success,
  });

  get isEmpty => rentabilityInPen!.isEmpty && rentabilityInUsd!.isEmpty;
}

enum TimePeriod {
  // allMonths,
  // threeYears,
  twoYears,
  year,
  midYear,
  quarterYear;

  String get value {
    switch (this) {
      // case TimePeriod.allMonths:
      //   return 'all_months';
      // case TimePeriod.threeYears:
      //   return 'three_years';
      case TimePeriod.twoYears:
        return 'two_years';
      case TimePeriod.year:
        return 'year';
      case TimePeriod.midYear:
        return 'mid_year';
      case TimePeriod.quarterYear:
        return 'quarter_year';
    }
  }

  String get spanishValue {
    switch (this) {
      // case TimePeriod.allMonths:
      //   return 'todos';
      // case TimePeriod.threeYears:
      //   return '36 meses';
      case TimePeriod.twoYears:
        return '24 meses';
      case TimePeriod.year:
        return '12 meses';
      case TimePeriod.midYear:
        return '6 meses';
      case TimePeriod.quarterYear:
        return '3 meses';
    }
  }
}
