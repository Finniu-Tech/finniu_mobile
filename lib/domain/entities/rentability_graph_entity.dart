class RentabilityGraphEntity {
  String month;
  String amountPoint;

  RentabilityGraphEntity({
    required this.month,
    required this.amountPoint,
  });

  RentabilityGraphEntity copyWith({
    String? month,
    String? amountPoint,
  }) {
    return RentabilityGraphEntity(
      month: month ?? this.month,
      amountPoint: amountPoint ?? this.amountPoint,
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
