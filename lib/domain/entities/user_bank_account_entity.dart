class BankAccount {
  final String bankName;
  final String bankAccount;
  final String currency;
  final String? alias;
  final String typeAccount;
  final bool isJointAccount;
  final bool isDefaultAccount;

  BankAccount({
    required this.bankName,
    required this.bankAccount,
    required this.currency,
    this.alias,
    required this.typeAccount,
    required this.isJointAccount,
    required this.isDefaultAccount,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      bankName: json['bankName'],
      bankAccount: json['bankAccount'],
      currency: json['currency'],
      alias: json['alias'],
      typeAccount: json['typeAccount'],
      isJointAccount: json['isJointAccount'],
      isDefaultAccount: json['isDefaultAccount'],
    );
  }
}
