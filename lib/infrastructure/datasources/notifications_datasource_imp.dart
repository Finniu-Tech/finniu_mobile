import 'dart:convert';
import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:finniu/infrastructure/models/notifications/notification_model.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:http/http.dart' as http;

class NotificationsDataSource {
  final String baseUrl;
  final http.Client _client;

  NotificationsDataSource({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<bool> saveDeviceToken(DeviceRegistrationModel deviceInfo) async {
    try {
      final uri = Uri.parse('$baseUrl/device');
      print('uri saveDeviceToken: $uri');
      print('device info: ${deviceInfo.toJson()}');

      final response = await _client.post(
        uri,
        headers: _headers,
        body: json.encode(deviceInfo.toJson()), // Importante: codificar a JSON
      );

      print('response save device token: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to save device token. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error saving device token: $e');
      rethrow;
    }
  }

  Future<List<NotificationModel>> getNotifications({
    required String userId,
  }) async {
    try {
      final queryParams = {
        'user_id': userId,
        'status': 'delivered',
        'from_date': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      };

      final uri = Uri.parse('$baseUrl/notification-logs');
      final response = await _client.post(
        uri,
        headers: _headers,
        body: jsonEncode(queryParams),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body)['data'];
        final List<dynamic> logs = data?['logs'] ?? [];

        return logs.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to get notifications. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error getting notifications: $e');
      rethrow;
    }
  }

  Future<bool> saveNotificationLog({
    required String title,
    required String body,
    required String userId,
    required String notificationType,
    required String status,
    required String deviceId,
    required String token,
    String? campaignId,
    String? parentNotificationUuid,
    Map<String, dynamic>? extraData,
  }) async {
    final deviceInfo = await DeviceInfoService().getDeviceInfo(userId);
    try {
      final payload = {
        'title': title,
        'body': body,
        'user_id': userId,
        'notification_type': notificationType,
        'status': status,
        'device_id': deviceId,
        'device_info': deviceInfo.toJson(),
        'campaign_id': campaignId,
        'token': token,
        'extra_data': extraData ?? {},
        if (parentNotificationUuid != null) 'parent_notification_uuid': parentNotificationUuid,
      };
      final response = await _client.post(
        Uri.parse('$baseUrl/register-log'),
        headers: _headers,
        body: json.encode(payload),
      );
      print('response save notification log~~~~~: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDevice({
    required String deviceId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/device/$deviceId');
      print('uri updateDevice: $uri');
      print('updates: $updates');

      final response = await _client.put(
        uri,
        headers: _headers,
        body: json.encode(updates),
      );

      print('response updateDevice: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to update device. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error updating device: $e');
      rethrow;
    }
  }

  Future<DeviceRegistrationModel?> getDeviceById({required String deviceId}) async {
    try {
      final uri = Uri.parse('$baseUrl/device/$deviceId');
      print('uri getDeviceById: $uri');

      final response = await _client.get(
        uri,
        headers: _headers,
      );

      print('response getDeviceById: ${response.body}');

      if (response.statusCode == 200) {
        print('statusCode: ${response.statusCode}');
        final data = json.decode(response.body);
        print('data: $data');
        if (data['success'] == true) {
          print('data222: ${data['data']}');
          final registerModel = DeviceRegistrationModel.fromJson(data['data']);
          print('registerModel: $registerModel');
          return registerModel;
        }
      }

      return null;
    } catch (e) {
      print('Error getting device: $e');
      rethrow;
    }
  }
}
