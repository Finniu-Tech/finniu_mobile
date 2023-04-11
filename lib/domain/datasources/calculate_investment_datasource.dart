import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class CalculateInvestmentDataSource {
  Future<PlanSimulation> calculate({
    required GraphQLClient client,
    required int amount,
    required int months,
  });
}
