import 'package:finniu/domain/datasources/change_password_logued.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChangePasswordLoguedDataSourceImp extends ChangePasswordLoguedDataSource {
  Future<bool> changePasswordLogued({
    required GraphQLClient client,
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.changePasswordLogued(),
        ),
        variables: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      ),
    );
    print('response change password');
    print(response);
    print('result!!');
    print(response.data?['changePassword']['success']);
    return response.data?['changePassword']['success'] ?? false;
  }
}
