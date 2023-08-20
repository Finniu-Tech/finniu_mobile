class AppVersionEntity {
  String newVersion;
  String minVersion;
  String? currentVersion;

  AppVersionEntity({
    required this.newVersion,
    required this.minVersion,
    this.currentVersion,
  });

  factory AppVersionEntity.fromJson(Map<String, dynamic> json) {
    return AppVersionEntity(
      newVersion: json['newVersion'],
      minVersion: json['minVersion'],
    );
  }

  needUpgrade() {
    if (currentVersion == null) {
      return false;
    }
    return currentVersion!.compareTo(minVersion) < 0;
  }
}
