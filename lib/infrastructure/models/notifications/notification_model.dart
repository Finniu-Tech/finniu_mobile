enum NotificationStatus { delivered, read, error }

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String deviceId;
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
    required this.deviceId,
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
      deviceId: json['device_id'],
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
