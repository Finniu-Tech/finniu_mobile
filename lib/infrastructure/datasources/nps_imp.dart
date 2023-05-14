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
    print('question');
    print(question);
    print('answer');
    print(answer);
    print('comment');
    print(comment);
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
    print('response');
    print(response);
    bool success = response.data?['saveNps']['success'];
    print('success save nps');
    print(success);
    return success;
  }
}
