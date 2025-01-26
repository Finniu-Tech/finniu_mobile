import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/calendar/rentability.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RentabilityDataSource extends GraphQLBaseDataSource {
  RentabilityDataSource(super.client);

  Future<RentabilityMonthResponse> getRentabilityPerMonth() async {
    final response = await client.query(
      QueryOptions(
        document: gql(QueryRepository.getRentabilityPerMonthAndUser),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    if (response.hasException) {
      throw response.exception!;
    }

    final data = response.data?['rentabilityPerMonthByUser'];
    if (data == null) {
      throw Exception('No data available');
    }

    return RentabilityMonthResponse.fromJson(data);
  }
}
