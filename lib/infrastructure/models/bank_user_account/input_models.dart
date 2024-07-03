class JointAccountInput {
  final String name;
  final String lastName;
  final String documentType;
  final String documentNumber;

  JointAccountInput({
    required this.name,
    required this.lastName,
    required this.documentType,
    required this.documentNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'documentType': documentType,
      'documentNumber': documentNumber,
    };
  }
}

class CreateBankAccountInput {
  final String bankUUID;
  final String typeAccount;
  final String currency;
  final String bankAccount;
  final String? aliasBankAccount;
  final bool isDefault;
  final bool isPersonalAccount;
  final JointAccountInput? jointAccount;

  CreateBankAccountInput({
    required this.bankUUID,
    required this.typeAccount,
    required this.currency,
    required this.bankAccount,
    required this.aliasBankAccount,
    required this.isDefault,
    required this.isPersonalAccount,
    this.jointAccount,
  });

  Map<String, dynamic> toJson() {
    return {
      'bankUUID': bankUUID,
      'typeAccount': typeAccount,
      'currency': currency,
      'bankAccount': bankAccount,
      'aliasBankAccount': aliasBankAccount,
      'isDefault': isDefault,
      'isPersonalAccount': isPersonalAccount,
      if (jointAccount != null) 'jointAccount': jointAccount!.toJson(),
    };
  }
}
