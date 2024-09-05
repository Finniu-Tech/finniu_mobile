class RegisterUserV2Response {
  final bool success;
  final List<Message> messages;
  final User? user;

  RegisterUserV2Response({
    required this.success,
    required this.messages,
    this.user,
  });

  factory RegisterUserV2Response.fromJson(Map<String, dynamic> json) {
    return RegisterUserV2Response(
      success: json['success'],
      messages: (json['messages'] as List)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'messages': messages.map((message) => message.toJson()).toList(),
      'user': user?.toJson(),
    };
  }
}

class Message {
  final String field;
  final String message;
  final String errorCode;

  Message({
    required this.field,
    required this.message,
    required this.errorCode,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      field: json['field'],
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'message': message,
      'errorCode': errorCode,
    };
  }
}

class User {
  final String id;
  final String email;

  User({
    required this.id,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}
