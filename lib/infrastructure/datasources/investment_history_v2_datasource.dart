import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/blue_gold_investment/progress_blue_gold.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvestmentHistoryV2DataSource extends GraphQLBaseDataSource {
  InvestmentHistoryV2DataSource(super.client);

  Future<List<AggroInvestment>> getAggroInvestmentList() async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getAggroInvestmentList,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final List<dynamic> listInvestmentResponse = response.data?['agroInvestmentList'] ?? [];
    final fundList = AggroInvestment.fromJsonList(listInvestmentResponse);
    return fundList;
  }
}
