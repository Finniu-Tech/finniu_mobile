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
