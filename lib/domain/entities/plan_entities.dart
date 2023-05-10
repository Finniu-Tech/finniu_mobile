class PlanEntity {
  String uuid;
  String name;
  String? description;
  String? imageUrl;
  double minAmount;
  double? value;
  double? twelveMonthsReturn;
  double? sixMonthsReturn;
  DateTime? returnEstimatedDate = DateTime.now();

  PlanEntity({
    required this.uuid,
    required this.name,
    this.description,
    this.imageUrl,
    required this.minAmount,
    this.value,
    this.twelveMonthsReturn,
    this.sixMonthsReturn,
    this.returnEstimatedDate,
  });

  PlanEntity copyWith({
    String? uuid,
    String? name,
    String? description,
    String? imageUrl,
    double? minAmount,
    double? value,
    double? twelveMonthsReturn,
    double? sixMonthsReturn,
    DateTime? returnEstimatedDate,
  }) {
    return PlanEntity(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      minAmount: minAmount ?? this.minAmount,
      value: value ?? this.value,
      twelveMonthsReturn: twelveMonthsReturn ?? this.twelveMonthsReturn,
      sixMonthsReturn: sixMonthsReturn ?? this.sixMonthsReturn,
      returnEstimatedDate: returnEstimatedDate ?? this.returnEstimatedDate,
    );
  }
}
