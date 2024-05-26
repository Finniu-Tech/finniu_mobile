class BankAccount {
  final String id;
  final String bankName;
  final String bankAccount;
  final String currency;
  final String? alias;
  final String typeAccount;
  final bool isJointAccount;
  final bool isDefaultAccount;

  BankAccount({
    required this.id,
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
      id: json['uuid'],
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
