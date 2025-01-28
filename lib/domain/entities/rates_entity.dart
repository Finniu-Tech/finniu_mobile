// lib/domain/entities/rate_entity.dart
class RateEntity {
  final String source;
  final String buyRate;
  final String sellRate;
  final DateTime timestamp;
  final DateTime lastUpdated;

  RateEntity({
    required this.source,
    required this.buyRate,
    required this.sellRate,
    required this.timestamp,
    required this.lastUpdated,
  });
}

// lib/domain/entities/rates_response_entity.dart
class RatesResponseEntity {
  final List<RateEntity> rates;
  final int count;
  final DateTime timestamp;

  RatesResponseEntity({
    required this.rates,
    required this.count,
    required this.timestamp,
  });
}

// lib/infrastructure/models/rate_model.dart
class RateModel {
  final String source;
  final String buyRate;
  final String sellRate;
  final String timestamp;
  final String lastUpdated;

  RateModel({
    required this.source,
    required this.buyRate,
    required this.sellRate,
    required this.timestamp,
    required this.lastUpdated,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      source: json['source'],
      buyRate: json['buy_rate'],
      sellRate: json['sell_rate'],
      timestamp: json['timestamp'],
      lastUpdated: json['last_updated'],
    );
  }

  RateEntity toEntity() {
    return RateEntity(
      source: source,
      buyRate: buyRate,
      sellRate: sellRate,
      timestamp: DateTime.parse(timestamp),
      lastUpdated: DateTime.parse(lastUpdated),
    );
  }
}

// lib/infrastructure/models/rates_response_model.dart
class RatesResponseModel {
  final List<RateModel> rates;
  final int count;
  final String timestamp;

  RatesResponseModel({
    required this.rates,
    required this.count,
    required this.timestamp,
  });

  factory RatesResponseModel.fromJson(Map<String, dynamic> json) {
    return RatesResponseModel(
      rates: (json['rates'] as List).map((rate) => RateModel.fromJson(rate)).toList(),
      count: json['count'],
      timestamp: json['timestamp'],
    );
  }

  RatesResponseEntity toEntity() {
    return RatesResponseEntity(
      rates: rates.map((rate) => rate.toEntity()).toList(),
      count: count,
      timestamp: DateTime.parse(timestamp),
    );
  }
}
