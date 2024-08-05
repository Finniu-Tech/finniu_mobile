import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/repositories/plan_repository.dart';
import 'package:finniu/infrastructure/datasources/plan_datasource_imp.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlanRepositoryImp implements PlanRepository {
  PlanRepositoryImp({
    required this.dataSource,
  });

  final PlanDataSourceImp dataSource;

  @override
  Future<PlanList> getAll({
    required GraphQLClient client,
  }) async {
    return await dataSource.getAll(
      client: client,
    );
  }
}
