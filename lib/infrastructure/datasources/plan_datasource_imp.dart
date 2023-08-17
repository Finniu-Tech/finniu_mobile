import 'package:finniu/domain/datasources/plan_datasource.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/mappers/plan_mapper.dart';
import 'package:finniu/infrastructure/models/plan_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlanDataSourceImp extends PlanDataSource {
  // @override
  // Future<List<PlanEntity>> getAll({
  //   required GraphQLClient client,
  // }) async {
  //   final response = await client.query(
  //     QueryOptions(
  //       document: gql(
  //         QueryRepository.getPlans,
  //       ),
  //     ),
  //   );
  //   final responsePlans = PlanListResponse.fromJson(
  //     response.data ?? {},
  //   );
  //   return PlanMapper.listToEntity(responsePlans);
  // }

  Future<PlanList> getAll({required GraphQLClient client}) async {
    final solesResponse = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getPlansSoles,
        ),
      ),
    );
    final dolarResponse = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getPlansDolar,
        ),
      ),
    );
    final plansSolesResponse = PlanListResponse.fromJson(
      solesResponse.data?['planSoles'] ?? {},
    );
    final plansDolarResponse =
        PlanListResponse.fromJson(dolarResponse.data?['planDolar'] ?? {});

    final solesMapped = PlanMapper.listToEntity(plansSolesResponse);
    final dolarMapped = PlanMapper.listToEntity(plansDolarResponse);
    return PlanList(soles: solesMapped, dolar: dolarMapped);
  }
}
