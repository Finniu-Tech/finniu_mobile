import 'dart:convert';
import 'package:finniu/infrastructure/models/notifications/device_info_model.dart';
import 'package:http/http.dart' as http;

class NotificationsDataSource {
  final String baseUrl;
  final http.Client _client;

  NotificationsDataSource({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  // Headers comunes
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<bool> saveDeviceToken(DeviceInfoModel deviceInfo) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/token-device'),
        headers: _headers,
        body: deviceInfo.toJsonString(),
      );

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
      };

      final uri = Uri.parse('$baseUrl/notification-logs');
      final response = await _client.post(
        uri,
        headers: _headers,
        body: jsonEncode(queryParams),
      );
      print('response notifications: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['logs'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
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

  // Marcar notificación como leída
  // Future<bool> markNotificationAsRead(String notificationId) async {
  //   try {
  //     final response = await _client.patch(
  //       Uri.parse('$baseUrl/notifications/$notificationId/read'),
  //       headers: _headers,
  //     );

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Error marking notification as read: $e');
  //     rethrow;
  //   }
  // }

  // // Obtener conteo de notificaciones no leídas
  // Future<int> getUnreadNotificationsCount(String userId) async {
  //   try {
  //     final response = await _client.get(
  //       Uri.parse('$baseUrl/notifications/unread-count?user_id=$userId'),
  //       headers: _headers,
  //     );

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body)['count'];
  //     } else {
  //       throw Exception(
  //         'Failed to get unread count. Status: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     print('Error getting unread count: $e');
  //     rethrow;
  //   }
  // }

  // Eliminar token de dispositivo
  // Future<bool> deleteDeviceToken(String token) async {
  //   try {
  //     final response = await _client.delete(
  //       Uri.parse('$baseUrl/token-device/$token'),
  //       headers: _headers,
  //     );

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Error deleting device token: $e');
  //     rethrow;
  //   }
  // }
}

// También necesitarás un modelo para las notificaciones:
// lib/models/notification_model.dart

enum NotificationStatus { delivered, read, error }

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final Map<String, dynamic>? extraData;
  final DateTime creationDate;
  final NotificationStatus status;
  final String? errorDetail;
  final bool isVisibleToUser;
  final String notificationType;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.extraData,
    required this.creationDate,
    required this.status,
    this.errorDetail,
    required this.isVisibleToUser,
    required this.notificationType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['uuid'],
      userId: json['user_id'],
      title: json['title'],
      body: json['body'],
      extraData: json['extra_data'],
      creationDate: DateTime.parse(json['creation_date']),
      status: NotificationStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == json['status'].toLowerCase(),
      ),
      errorDetail: json['error_detail'],
      isVisibleToUser: json['is_visible_to_user'],
      notificationType: json['notification_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': id,
        'user_id': userId,
        'title': title,
        'body': body,
        'extra_data': extraData,
        'creation_date': creationDate.toIso8601String(),
        'status': status.name.toLowerCase(),
        'error_detail': errorDetail,
        'is_visible_to_user': isVisibleToUser,
        'notification_type': notificationType,
      };
}
