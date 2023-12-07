class PlanList {
  List<PlanEntity> soles;
  List<PlanEntity> dolar;

  PlanList({required this.soles, required this.dolar});
}

class PlanEntity {
  String uuid;
  String name;
  String? description;
  String? objective;
  String? imageUrl;
  String? imgDistribution;
  double minAmount;
  double? value;
  double? twelveMonthsReturn;
  double? sixMonthsReturn;
  List<String?> features = [];
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
    this.objective,
    this.imgDistribution,
    this.features = const [],
  });

  PlanEntity copyWith({
    String? uuid,
    String? name,
    String? description,
    String? imageUrl,
    String? objective,
    String? imgDistribution,
    double? minAmount,
    double? value,
    double? twelveMonthsReturn,
    double? sixMonthsReturn,
    DateTime? returnEstimatedDate,
    List<String?>? features,
  }) {
    return PlanEntity(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      objective: objective ?? this.objective,
      imageUrl: imageUrl ?? this.imageUrl,
      minAmount: minAmount ?? this.minAmount,
      value: value ?? this.value,
      twelveMonthsReturn: twelveMonthsReturn ?? this.twelveMonthsReturn,
      sixMonthsReturn: sixMonthsReturn ?? this.sixMonthsReturn,
      returnEstimatedDate: returnEstimatedDate ?? this.returnEstimatedDate,
      imgDistribution: imgDistribution ?? this.imgDistribution,
      features: features ?? this.features,
    );
  }
}
