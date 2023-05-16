import 'package:graphql/client.dart';

import '../../domain/datasources/transferences_datasource.dart';
import '../../graphql/queries.dart';
import '../models/plan_response.dart';

class TransferenceDataSourceImpl extends TransferenceDataSource {
  final GraphQLClient client;

  TransferenceDataSourceImpl({required this.client});

  @override
  Future<List<String>> getBoucherList({required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.userGetBouchers,
        ),
      ),
    );
    print('get onboarding data******');
    print(response);
    return [];
  }
}
