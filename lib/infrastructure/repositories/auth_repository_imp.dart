import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthRepository {
  Future<LoginResponseAPI> login({
    required GraphQLClient client,
    required String username,
    required String password,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.loginUser(),
        ),
        variables: {'username': username, 'password': password},
      ),
    );

    return LoginResponseAPI(
      success: response.data?['loginUser']['success'],
      error: response.data?['loginUser']?['messages']?[0]['message'] ?? 'Ocurrió un error al iniciar sesión',
    );
  }
}
