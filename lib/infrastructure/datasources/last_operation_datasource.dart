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
      ),
    );
    print('response get last operation: ${response.data}');

    if (response.hasException) {
      throw response.exception!;
    }

    final List<dynamic> data = response.data!['getStatusLastOperation'];

    return data.map((json) => LastOperation.fromJson(json)).toList();
  }
}
