class Investment {
  final String uuid;
  final int amount;
  final String finishDateInvestment;

  Investment({
    required this.uuid,
    required this.amount,
    required this.finishDateInvestment,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      finishDateInvestment: json['finishDateInvestment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'amount': amount.toString(),
      'finishDateInvestment': finishDateInvestment,
    };
  }

  static int _parseAmount(String amount) {
    // Convierte la cadena a un double primero
    double parsedDouble = double.parse(amount);

    // Asegúrate de que el double se puede convertir a int sin perder precisión
    if (parsedDouble == parsedDouble.toInt()) {
      return parsedDouble.toInt();
    } else {
      throw FormatException("Invalid amount format: $amount");
    }
  }
}

class InvestmentCategory {
  final List<Investment> investmentPending;
  final List<Investment> investmentInCourse;
  final List<Investment> investmentFinished;

  InvestmentCategory({
    required this.investmentPending,
    required this.investmentInCourse,
    required this.investmentFinished,
  });

  factory InvestmentCategory.fromJson(Map<String, dynamic> json) {
    return InvestmentCategory(
      investmentPending: (json['investmentPending'] as List)
          .map((item) => Investment.fromJson(item))
          .toList(),
      investmentInCourse: (json['invesmentInCourse'] as List)
          .map((item) => Investment.fromJson(item))
          .toList(),
      investmentFinished: (json['invesmentFinished'] as List)
          .map((item) => Investment.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'investmentPending': investmentPending.map((e) => e.toJson()).toList(),
      'invesmentInCourse': investmentInCourse.map((e) => e.toJson()).toList(),
      'invesmentFinished': investmentFinished.map((e) => e.toJson()).toList(),
    };
  }
}

class UserInfoAllInvestment {
  final InvestmentCategory investmentInSoles;
  final InvestmentCategory investmentInDolares;

  UserInfoAllInvestment({
    required this.investmentInSoles,
    required this.investmentInDolares,
  });

  factory UserInfoAllInvestment.fromJson(Map<String, dynamic> json) {
    return UserInfoAllInvestment(
      investmentInSoles:
          InvestmentCategory.fromJson(json['invesmentInSoles'][0]),
      investmentInDolares:
          InvestmentCategory.fromJson(json['invesmentInDolares'][0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invesmentInSoles': [investmentInSoles.toJson()],
      'invesmentInDolares': [investmentInDolares.toJson()],
    };
  }
}

class Data {
  final UserInfoAllInvestment userInfoAllInvestment;

  Data({
    required this.userInfoAllInvestment,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userInfoAllInvestment:
          UserInfoAllInvestment.fromJson(json['userInfoAllInvestment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userInfoAllInvestment': userInfoAllInvestment.toJson(),
    };
  }
}
