class TypeAccountEnum {
  static const String SAVINGS = 'AHORROS';
  static const String CORRIENTE = 'CORRIENTE';
  static const String JOINT = 'MANCOMUNADA';

  static String mapTypeAccountToLabel(String typeAccount) {
    switch (typeAccount) {
      case 'Ahorros':
        return SAVINGS;
      case 'Corriente':
        return CORRIENTE;
      case 'Mancomunada':
        return JOINT;

      default:
        return '';
    }
  }
}

class CurrencyEnum {
  static const String PEN = 'SOLES';
  static const String USD = 'DOLARES';
}

class BankAccount {
  final String id;
  final String bankName;
  final String bankAccount;
  final String? cci;
  final String currency;
  final String? alias;
  final String typeAccount;
  final bool isJointAccount;
  final bool isDefaultAccount;
  final String? bankLogoUrl;
  final String bankSlug;

  BankAccount(
      {required this.id,
      required this.bankName,
      required this.bankAccount,
      required this.currency,
      this.alias,
      this.cci,
      required this.typeAccount,
      required this.isJointAccount,
      required this.isDefaultAccount,
      this.bankLogoUrl,
      required this.bankSlug});

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
        id: json['uuid'],
        bankName: json['bankName'],
        bankAccount: json['bankAccount'],
        currency: json['currency'],
        alias: json['alias'],
        typeAccount: json['typeAccount'],
        isJointAccount: json['isJointAccount'],
        isDefaultAccount: json['isDefaultAccount'],
        cci: json['bankCciAccount'],
        bankLogoUrl: json['bankLogoUrl'],
        bankSlug: json['bankSlug']);
  }
  static getSafeBankAccountNumber(String bankAccount) {
    if (bankAccount.length > 4) {
      // return '************ ${bankAccount.substring(bankAccount.length - 4)}';
      return bankAccount;
    }
    return bankAccount;
  }
}
