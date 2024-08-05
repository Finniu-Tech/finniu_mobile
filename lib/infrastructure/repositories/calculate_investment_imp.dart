import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/repositories/calculate_investment_repository.dart';
import 'package:finniu/infrastructure/datasources/calculate_investment_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CalculateInvestmentRepositoryImp implements CalculateInvestmentRepository {
  CalculateInvestmentRepositoryImp({required this.dataSource});

  final CalculateInvestmentDataSourceImp dataSource;

  @override
  Future<PlanSimulation> calculate({
    required GraphQLClient client,
    required int amount,
    required int months,
    String? currency,
    String? coupon,
  }) {
    return dataSource.calculate(
      client: client,
      amount: amount,
      months: months,
      coupon: coupon,
      currency: currency,
    );
  }
}
