import 'package:finniu/domain/datasources/contract.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ContractDataSourceImp extends ContractDataSource {
  @override
  Future<String> getContract({
    required String uuid,
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.contractUrl,
        ),
        variables: {
          'uuid': uuid,
        },
      ),
    );
    print('get contract data******');
    print(response);
    return response.data?['getContractPreinvestment']['contract'];
  }
}
