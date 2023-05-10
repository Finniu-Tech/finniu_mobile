class DeadLineEntity {
  String uuid;
  bool isActive;
  String name;
  int value;
  String description;

  DeadLineEntity({
    required this.uuid,
    required this.isActive,
    required this.name,
    required this.value,
    required this.description,
  });

  static String getUuidByName(String name, List<DeadLineEntity> deadLines) {
    return deadLines.firstWhere((element) => element.name == name).uuid;
  }
}
