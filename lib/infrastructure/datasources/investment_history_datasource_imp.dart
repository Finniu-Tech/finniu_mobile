import 'package:finniu/domain/datasources/investment_history.dart';
import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/calculate_investment_mapper.dart';
import 'package:finniu/infrastructure/mappers/investment_rentability_report_mapper.dart';
import 'package:finniu/infrastructure/models/investment_rentability_report_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvestmentHistoryDataSourceImp extends InvestmentHistoryDataSource {
  Future<InvestmentRentabilityResumeEntity> getRentabilityReport({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.investmentRentabilityReport,
        ),
      ),
    );
    print('investment resoonse');
    print(response);
    final responseGraphRentability = UserInfoInvestmentReportResponse.fromJson(
      response.data ?? {},
    );
    return InvestmentRentabilityReportMapper.graphResponseToEntity(
      responseGraphRentability,
    );
    // InvestmentRentabilityR.toEntity(responseGraphRentability);
  }

  // Future<InvestmentHistoryResumeEntity> getInvestmentHistoryReport({
  //   required GraphQLClient client,
  // }) {
  //   return InvestmentHistoryEntity(
  //       uuid: '1', planName: 'test', totalAmount: 100, status: 'status');
  // }
// }
}
