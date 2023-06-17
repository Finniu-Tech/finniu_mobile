import 'package:finniu/domain/datasources/nps.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NPSDataSourceImpl implements NPSDataSource {
  @override
  Future<bool> save({
    required GraphQLClient client,
    required String question,
    required String answer,
    required String comment,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.saveNPS(),
        ),
        variables: {
          'question': question,
          'answer': answer,
          'text': comment,
        },
      ),
    );
    bool success = response.data?['saveNps']['success'];

    return success;
  }
}
