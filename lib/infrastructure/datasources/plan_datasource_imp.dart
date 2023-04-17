import 'package:finniu/domain/datasources/plan_datasource.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/plan_mapper.dart';
import 'package:finniu/infrastructure/models/plan_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlanDataSourceImp extends PlanDataSource {
  @override
  Future<List<PlanEntity>> getAll({
    required GraphQLClient client,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getPlans,
        ),
      ),
    );
    print('get onboarding data******');
    print(response);
    final responsePlans = PlanListResponse.fromJson(
      response.data ?? {},
    );
    return PlanMapper.listToEntity(responsePlans);
  }
}
