enum Currency { PEN, USD }

class MoneyRateModel {
  final Currency currency;
  final double sunatBuyPrice;
  final double sunatSellPrice;
  final double rextieBuyPrice;
  final double rextieSellPrice;
  final String date;

  MoneyRateModel({
    required this.currency,
    required this.sunatBuyPrice,
    required this.sunatSellPrice,
    required this.rextieBuyPrice,
    required this.rextieSellPrice,
    required this.date,
  });
}

class SunatRateResponse {
  final double buyPrice;
  final double sellPrice;
  final String date;

  SunatRateResponse({
    required this.buyPrice,
    required this.sellPrice,
    required this.date,
  });

  factory SunatRateResponse.fromJson(Map<String, dynamic> json) {
    return SunatRateResponse(
      buyPrice: json['precioCompra']?.toDouble() ?? 0.0,
      sellPrice: json['precioVenta']?.toDouble() ?? 0.0,
      date: json['fecha'] ?? '',
    );
  }
}

class RextieAuthResponse {
  final String accessToken;

  RextieAuthResponse({required this.accessToken});

  factory RextieAuthResponse.fromJson(Map<String, dynamic> json) {
    return RextieAuthResponse(
      accessToken: json['access_token'],
    );
  }
}

class RextieRateResponse {
  final double buyRate;
  final double sellRate;

  RextieRateResponse({
    required this.buyRate,
    required this.sellRate,
  });

  factory RextieRateResponse.fromJson(Map<String, dynamic> json) {
    return RextieRateResponse(
      buyRate: json['fx_rate_buy']?.toDouble() ?? 0.0,
      sellRate: json['fx_rate_sell']?.toDouble() ?? 0.0,
    );
  }
}
