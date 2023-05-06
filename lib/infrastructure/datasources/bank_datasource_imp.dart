import 'package:finniu/domain/datasources/bank_datasource.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/bank_mapper.dart';
import 'package:finniu/infrastructure/models/bank_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BankDataSourceImp extends BankDataSource {
  @override
  Future<List<BankEntity>> getBanks({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getBanks,
        ),
      ),
    );
    print('get onboarding data******');
    print(response);
    final responseBanks = BankResponse.fromJson(
      response.data ?? {},
    );
    return BankMapper.listToEntity(responseBanks);
  }
}
