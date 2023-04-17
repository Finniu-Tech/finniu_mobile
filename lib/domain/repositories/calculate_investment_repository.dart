import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class CalculateInvestmentRepository {
  Future<PlanSimulation> calculate({
    required GraphQLClient client,
    required int amount,
    required int months,
  });
}
