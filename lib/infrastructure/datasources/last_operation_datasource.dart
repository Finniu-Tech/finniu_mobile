import 'package:finniu/domain/entities/last_operation_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LastOperationDataSource extends GraphQLBaseDataSource {
  LastOperationDataSource(super.client);

  Future<List<LastOperation>> getLastOperations(String fundUUID) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getLastOperationStatus,
        ),
        variables: {
          'fundUUID': fundUUID,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (response.hasException) {
      throw response.exception!;
    }

    final List<dynamic> data = response.data!['getStatusLastOperation'] ?? [];

    if (data.isEmpty) {
      return <LastOperation>[];
    }

    return data.map((item) => LastOperation.fromJson(item as Map<String, dynamic>)).toList();
  }
}
