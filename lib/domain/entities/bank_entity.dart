class BankEntity {
  final String uuid;
  final bool isActive;
  final String name;
  final String? logoUrl;
  final String? cardImageUrl;

  BankEntity({required this.uuid, required this.name, required this.isActive, this.cardImageUrl, this.logoUrl});

  static String getUuidByName(String name, List<BankEntity> banks) {
    return banks.firstWhere((element) => element.name == name).uuid;
  }

  static BankEntity getBankByName(String name, List<BankEntity> banks) {
    return banks.firstWhere((element) => element.name == name);
  }
}
