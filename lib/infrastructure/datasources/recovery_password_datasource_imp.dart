import 'package:finniu/domain/datasources/recovery_password_datasource.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/recovery_password_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RecoveryPasswordDataSourceImp extends RecoveryPasswordDataSource {
  @override
  Future<bool> sendEmailRecoveryPassword({
    required GraphQLClient client,
    required String email,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.sendEmailRecoveryPassword(),
        ),
        variables: {
          'email': email,
        },
      ),
    );
    print('get onboarding data******');
    print(response);
    final responseData = RecoveryPasswordData.fromJson(
      response.data!,
    );
    return responseData.recoveryPassword?.success ?? false;
  }
}
