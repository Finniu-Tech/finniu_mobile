class RentabilityMonthResponse {
  final String rentabilityPercent;
  final String rentabilityPerMonth;

  RentabilityMonthResponse({
    required this.rentabilityPercent,
    required this.rentabilityPerMonth,
  });

  factory RentabilityMonthResponse.fromJson(Map<String, dynamic> json) {
    return RentabilityMonthResponse(
      rentabilityPercent: json['rentabilityPercent'] ?? '0',
      rentabilityPerMonth: json['rentabilityPerMonth'] ?? '0',
    );
  }
}
