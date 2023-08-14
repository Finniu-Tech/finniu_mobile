import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class InvestmentHistoryDataSource {
  Future<InvestmentRentabilityReport> getRentabilityReport({
    required GraphQLClient client,
  });

  Future<InvestmentHistoryReport> getInvestmentHistoryReport({
    required GraphQLClient client,
  });
}
