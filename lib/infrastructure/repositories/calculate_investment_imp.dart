import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/datasources/calculate_investment_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CalculateInvestmentRepositoryImp {
  CalculateInvestmentRepositoryImp({required this.dataSource});

  final CalculateInvestmentDataSourceImp dataSource;

  Future<PlanSimulation> calculate({
    required GraphQLClient client,
    required int amount,
    required int months,
    required String fundUuid,
    required String currency,
    String? coupon,
  }) {
    return dataSource.calculate(
      client: client,
      amount: amount,
      months: months,
      coupon: coupon,
      currency: currency,
      fundUuid: fundUuid,
    );
  }
}
