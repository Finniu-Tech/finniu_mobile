class GraphQLErrorMessage {
  final String field;
  final String message;
  final String? errorCode;

  GraphQLErrorMessage({
    required this.field,
    required this.message,
    required this.errorCode,
  });

  factory GraphQLErrorMessage.fromJson(Map<String, dynamic> json) {
    return GraphQLErrorMessage(
      field: json['field'] as String,
      message: json['message'] as String,
      errorCode: json['errorCode'] as String?,
    );
  }
}
