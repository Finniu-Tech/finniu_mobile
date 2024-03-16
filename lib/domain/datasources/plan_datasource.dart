import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class PlanDataSource {
  Future<PlanList> getAll({
    required GraphQLClient client,
  });
}
