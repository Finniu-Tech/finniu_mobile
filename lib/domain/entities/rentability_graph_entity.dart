class RentabilityGraphEntity {
  String month;
  String amountPoint;
  dynamic typename;

  RentabilityGraphEntity({
    required this.month,
    required this.amountPoint,
    this.typename,
  });

  RentabilityGraphEntity copyWith({
    String? month,
    String? amountPoint,
    dynamic typename,
  }) {
    return RentabilityGraphEntity(
      month: month ?? this.month,
      amountPoint: amountPoint ?? this.amountPoint,
      typename: typename ?? this.typename,
    );
  }

  factory RentabilityGraphEntity.fromJson(Map<String, dynamic> json) {
    return RentabilityGraphEntity(
      month: json['month'],
      amountPoint: json['amountPoint'].toString(),
      typename: json['__typename'],
    );
  }
}

class RentabilityGraphResponseAPI {
  List<RentabilityGraphEntity>? rentabilityInPen;
  List<RentabilityGraphEntity>? rentabilityInUsd;
  String? error;
  bool? success;

  RentabilityGraphResponseAPI({
    this.rentabilityInPen,
    this.rentabilityInUsd,
    this.error,
    this.success,
  });
}

enum TimePeriod {
  allMonths,
  threeYears,
  twoYears,
  year,
  midYear,
  quarterYear;

  String get value {
    switch (this) {
      case TimePeriod.allMonths:
        return 'all_months';
      case TimePeriod.threeYears:
        return 'three_years';
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
      case TimePeriod.allMonths:
        return 'todos';
      case TimePeriod.threeYears:
        return '3 años';
      case TimePeriod.twoYears:
        return '2 años';
      case TimePeriod.year:
        return '1 año';
      case TimePeriod.midYear:
        return '6 meses';
      case TimePeriod.quarterYear:
        return '3 meses';
    }
  }
}
