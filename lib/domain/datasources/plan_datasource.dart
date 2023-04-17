import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class PlanDataSource {
  Future<List<PlanEntity>> getAll({
    required GraphQLClient client,
  });
}
