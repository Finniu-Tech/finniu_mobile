// lib/services/device_info_service.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';

class DeviceInfoService {
  Future<String> _getInstallationId() async {
    String? installId = Preferences.installationId;

    if (installId == null) {
      installId = '${DateTime.now().millisecondsSinceEpoch}_${const Uuid().v4()}';
      Preferences.installationId = installId;
    }

    return installId;
  }

  Future<DeviceInfoModel> getDeviceInfo(String userId) async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final installationId = await _getInstallationId();

      if (fcmToken == null) {
        throw Exception('Failed to get FCM token');
      }

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final deviceId = '${androidInfo.id}_$installationId';

        // Agregar logs para debug
        print('Android Info:');
        print('Android ID: ${androidInfo.id}');
        print('Installation ID: $installationId');
        print('Final Device ID: $deviceId');

        return DeviceInfoModel(
          deviceId: deviceId,
          token: fcmToken,
          userId: userId,
          appVersion: packageInfo.version,
          deviceInfo: DeviceDetails(
            os: 'android',
            osVersion: androidInfo.version.release,
            deviceModel: androidInfo.model,
            manufacturer: androidInfo.manufacturer,
          ),
          deviceName: androidInfo.model,
          platform: PlatformType.android,
        );
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return DeviceInfoModel(
          deviceId: iosInfo.identifierForVendor ?? '',
          token: fcmToken,
          userId: userId,
          appVersion: packageInfo.version,
          deviceInfo: DeviceDetails(
            os: 'ios',
            osVersion: iosInfo.systemVersion,
            deviceModel: iosInfo.model,
          ),
          deviceName: iosInfo.name,
          platform: PlatformType.ios,
        );
      }
      throw PlatformException(code: 'UNSUPPORTED_PLATFORM');
    } catch (e) {
      throw Exception('Failed to get device info: $e');
    }
  }

  // Future<bool> saveDeviceInfo(DeviceRegistrationModel deviceInfo) async {
  //   final bool success =
  //       await NotificationsDataSource(baseUrl: appConfig.notificationsBaseUrl).saveDeviceToken(deviceInfo);
  //   return success;
  // }
  // Future<void> saveDeviceInfo(DeviceInfoModel deviceInfo) async {
}
