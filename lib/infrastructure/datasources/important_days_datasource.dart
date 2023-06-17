import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ImportantDaysDataSourceImp {
  Future<List<dynamic>> getImportantDays({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.importantDays,
        ),
      ),
    );

    return response.data?['importantDays'] ?? [];
  }
}
