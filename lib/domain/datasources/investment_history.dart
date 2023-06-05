import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class InvestmentHistoryDataSource {
  Future<InvestmentRentabilityResumeEntity> getRentabilityReport({
    required GraphQLClient client,
  });

  Future<InvestmentHistoryResumeEntity> getInvestmentHistoryReport({
    required GraphQLClient client,
  });
}
