import 'package:finniu/domain/datasources/calculate_investment_datasource.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/mappers/calculate_investment_mapper.dart';
import 'package:finniu/infrastructure/models/calculate_investment_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CalculateInvestmentDataSourceImp extends CalculateInvestmentDataSource {
  @override
  Future<PlanSimulation> calculate({
    required GraphQLClient client,
    required int amount,
    required int months,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.calculateInvestment(),
        ),
        variables: {
          'amount': amount,
          'deadline': months,
        },
      ),
    );
    print('response!!!');
    print(response);
    final responseGraphQL = CalculateInvestmentResponse.fromJson(
      response.data!,
    );
    return CalculateInvestmentMapper.toEntity(responseGraphQL);
  }
}
