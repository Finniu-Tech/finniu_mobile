// lib/models/device_info_model.dart
import 'dart:convert';

import 'package:finniu/infrastructure/models/notifications/notification_model.dart';

enum PlatformType { android, ios }

class DeviceRegistrationModel {
  final DeviceInfoModel deviceInfo;
  final NotificationPreferences notificationPreferences;

  DeviceRegistrationModel({
    required this.deviceInfo,
    NotificationPreferences? notificationPreferences,
  }) : this.notificationPreferences = notificationPreferences ?? NotificationPreferences();

  Map<String, dynamic> toJson() => {
        ...deviceInfo.toJson(),
        ...notificationPreferences.toJson(),
      };
  factory DeviceRegistrationModel.fromJson(Map<String, dynamic> json) {
    return DeviceRegistrationModel(
      deviceInfo: DeviceInfoModel.fromJson(json),
      notificationPreferences: NotificationPreferences.fromJson(json),
    );
  }
}

class DeviceInfoModel {
  final String deviceId;
  final String token;
  final String userId;
  final String appVersion;
  final DeviceDetails deviceInfo;
  final String deviceName;
  final PlatformType platform;
  final DateTime lastUsed;
  final DateTime creationDate;

  DeviceInfoModel({
    required this.deviceId,
    required this.token,
    required this.userId,
    required this.appVersion,
    required this.deviceInfo,
    required this.deviceName,
    required this.platform,
    DateTime? lastUsed,
    DateTime? creationDate,
  })  : this.lastUsed = lastUsed ?? DateTime.now(),
        this.creationDate = creationDate ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'token': token,
        'user_id': userId,
        'app_version': appVersion,
        'device_info': deviceInfo.toJson(),
        'device_name': deviceName,
        'platform': platform.name,
        'last_used': lastUsed.toIso8601String(),
        'creation_date': creationDate.toIso8601String(),
      };

  String toJsonString() => json.encode(toJson());

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return DeviceInfoModel(
      deviceId: json['device_id'],
      token: json['token'],
      userId: json['user_id'],
      appVersion: json['app_version'],
      deviceInfo: DeviceDetails.fromJson(json['device_info']),
      deviceName: json['device_name'],
      platform: PlatformType.values.firstWhere(
        (e) => e.name == json['platform'],
        orElse: () => PlatformType.android,
      ),
      lastUsed: DateTime.parse(json['last_used']),
      creationDate: DateTime.parse(json['creation_date']),
    );
  }
}

class DeviceDetails {
  final String os;
  final String osVersion;
  final String deviceModel;
  final String? manufacturer;

  DeviceDetails({
    required this.os,
    required this.osVersion,
    required this.deviceModel,
    this.manufacturer,
  });

  Map<String, dynamic> toJson() => {
        'os': os,
        'os_version': osVersion,
        'device_model': deviceModel,
        if (manufacturer != null) 'manufacturer': manufacturer,
      };

  factory DeviceDetails.fromJson(Map<String, dynamic> json) {
    return DeviceDetails(
      os: json['os'],
      osVersion: json['os_version'],
      deviceModel: json['device_model'],
      manufacturer: json['manufacturer'],
    );
  }
}
