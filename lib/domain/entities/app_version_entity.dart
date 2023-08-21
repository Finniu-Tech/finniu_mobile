class StatusVersion {
  static const String upgrade = "UPGRADE";
  static const String forceUpgrade = "FORCED_UPGRADE";
  static const String equal = "EQUAL";
}

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
      newVersion: json['maxValue'],
      minVersion: json['minValue'],
    );
  }

  getStatusVersion() {
    if (isNewerThan(minVersion, currentVersion!)) {
      return StatusVersion.forceUpgrade;
    } else if (isNewerThan(newVersion, currentVersion!)) {
      return StatusVersion.upgrade;
    } else {
      return StatusVersion.equal;
    }
  }

  bool isNewerThan(String lastVersion, String currentVersion) {
    final List<String> lastVersionList = lastVersion.split('.');
    final List<String> currentVersionList = currentVersion.split('.');

    for (int i = 0; i < lastVersionList.length; i++) {
      if (int.parse(currentVersionList[i]) > int.parse(lastVersionList[i])) {
        return false;
      } else if (int.parse(currentVersionList[i]) <
          int.parse(lastVersionList[i])) {
        return true;
      }
    }
    return false;
  }
}
