import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EmailResetImp extends GraphQLBaseDataSource {
  EmailResetImp(super.client);

  Future<bool> emailReset() async {
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.emailReset(),
          ),
          variables: const {
            "inputEmail": {
              "email": "",
              "clientMutationId": "",
            },
          },
        ),
      );

      if (response.data == null) {
        return false;
      }

      if (response.data?['emailResetPassword']['success']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
