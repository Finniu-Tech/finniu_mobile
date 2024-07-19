import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FundDataSource extends GraphQLBaseDataSource {
  FundDataSource(super.client);

  Future<List<FundEntity>> getFunds() async {
    // HERE WE RETURN THE ACTIVE FUNDS
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getFunds,
        ),
        fetchPolicy: FetchPolicy.noCache, //TODO REMOVE CACHE
      ),
    );
    final List<dynamic> listInvestmentResponse =
        response.data?['investmentFundsQueries']?['listInvestmentFundsAvailable'] ?? [];

    final fundList = FundEntity.listFromJson(listInvestmentResponse);
    return fundList;
  }

  Future<List<FundBenefit>> getBenefits(String fundUUID) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getBenefitsFund,
        ),
        variables: {
          'fundUUID': fundUUID,
        },

        fetchPolicy: FetchPolicy.noCache, //TODO REMOVE CACHE
      ),
    );
    final List<dynamic> listInvestmentResponse =
        response.data?['investmentFundsQueries']?['listBenefitsInvestmentFundsAvailable'] ?? [];

    final fundList = FundBenefit.listFromJson(listInvestmentResponse);
    return fundList;
  }
}