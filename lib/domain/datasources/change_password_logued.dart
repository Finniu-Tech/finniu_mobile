import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ChangePasswordLoguedDataSource {
  Future<bool> changePasswordLogued({
    required GraphQLClient client,
    required String oldPassword,
    required String newPassword,
  });
}
