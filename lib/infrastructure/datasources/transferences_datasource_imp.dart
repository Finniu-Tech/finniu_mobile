import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:finniu/infrastructure/mappers/transference_mapper.dart';
import 'package:finniu/infrastructure/models/transference_response.dart';
import 'package:graphql/client.dart';

import '../../domain/datasources/transferences_datasource.dart';
import '../../graphql/queries.dart';

class TransferenceDataSourceImpl extends TransferenceDataSource {
  TransferenceDataSourceImpl();

  @override
  Future<List<TransferenceEntity>> getBoucherList({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.userGetBouchers,
        ),
      ),
    );
    final responseBoucher = UserGetBoucherResponse.fromJson(response.data!);
    return TransferenceMapper.listToEntity(responseBoucher);
  }
}
