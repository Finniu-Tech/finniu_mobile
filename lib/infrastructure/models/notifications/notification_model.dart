enum NotificationStatus { delivered, read, error }

enum PushStatus { active, denied }

class NotificationPreferences {
  final bool acceptsOperational;
  final bool acceptsMarketing;
  final PushStatus permissionState;

  NotificationPreferences({
    this.acceptsOperational = true,
    this.acceptsMarketing = true,
    this.permissionState = PushStatus.active,
  });

  Map<String, dynamic> toJson() => {
        'accepts_operational': acceptsOperational,
        'accepts_marketing': acceptsMarketing,
        'state': permissionState.name,
      };

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      acceptsOperational: json['accepts_operational'] ?? true,
      acceptsMarketing: json['accepts_marketing'] ?? true,
      permissionState: json['state'] != null
          ? PushStatus.values.firstWhere(
              (e) => e.name == json['state'],
              orElse: () => PushStatus.active,
            )
          : PushStatus.active,
    );
  }
}

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
