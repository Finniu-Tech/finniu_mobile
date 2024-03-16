import 'package:finniu/domain/datasources/investment_history.dart';
import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/investment_history_mapper.dart';
import 'package:finniu/infrastructure/mappers/investment_rentability_report_mapper.dart';
import 'package:finniu/infrastructure/models/investment_history_response.dart';
import 'package:finniu/infrastructure/models/investment_rentability_report_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvestmentHistoryDataSourceImp extends InvestmentHistoryDataSource {
  Future<InvestmentRentabilityReport> getRentabilityReport({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.investmentRentabilityReportV2,
        ),
      ),
    );
    final data = response.data?['userInfoAllInvestment'];
    final solesResponse = UserInfoInvestmentReportResponse.fromJson(
      data['invesmentInSoles'][0] ?? {},
    );
    final dollarsResponse = UserInfoInvestmentReportResponse.fromJson(
      data['invesmentInDolares'][0] ?? {},
    );
    // final responseGraphRentability = UserInfoInvestmentReportResponse.fromJson(
    //   response.data ?? {},
    // );

    return InvestmentRentabilityReport(
      solesRentability: InvestmentRentabilityReportMapper.graphResponseToEntity(
        solesResponse,
      ),
      dollarsRentability: InvestmentRentabilityReportMapper.graphResponseToEntity(
        dollarsResponse,
      ),
    );
  }

  Future<InvestmentHistoryReport> getInvestmentHistoryReport({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.investmentHistoryReportV2,
        ),
      ),
    );
    final data = response.data?['userInfoAllInvestment'];
    print('data: $data');
    final solesHistoryResponse = HistoryInvestmentResponse.fromJson(
      data['invesmentInSoles'][0] ?? {},
    );
    print('solesHistoryResponse: $solesHistoryResponse');
    final dollarsHistoryResponse = HistoryInvestmentResponse.fromJson(
      data['invesmentInDolares'][0] ?? {},
    );
    print('dollarsHistoryResponse: $dollarsHistoryResponse');
    return InvestmentHistoryReport(
      dollarsHistory: InvestmentHistoryMapper.responseGraphToEntity(dollarsHistoryResponse),
      solesHistory: InvestmentHistoryMapper.responseGraphToEntity(solesHistoryResponse),
    );
  }
}
