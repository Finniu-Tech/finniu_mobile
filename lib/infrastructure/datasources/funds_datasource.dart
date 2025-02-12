import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/fund/aggro_investment_models.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FundDataSource extends GraphQLBaseDataSource {
  FundDataSource(super.client);

  Future<List<FundEntity>> getFunds() async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.getFunds,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    print('response get fundss $response');

    final List<dynamic> listInvestmentResponse =
        response.data?['investmentFundsQueries']?['listInvestmentFundsAvailable'] ?? [];

    final fundList = FundEntity.listFromJson(listInvestmentResponse);
    // Filtrar solo los fondos activos
    return fundList.where((fund) => fund.isActive == true).toList();
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
    return fundList.where((benefit) => benefit.isActive == true).toList();
  }

  Future<List<int>> getAggroQuotes() async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.aggroInvestmentQuotes,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final quoteList = response.data?['agroInvestmentQueries']['calculateQuotesAvailable'];
    //iterate over the quoteList and parse each vaalue to int
    return (quoteList as List<dynamic>).map((quote) => quote as int).toList();
  }

  //TODO calculate aggro investment

  Future<CalculateAggroInvestmentResponse> calculateAggroInvestment(CalculateAggroInvestmentInput input) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.calculateAggroInvestment(),
        ),
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return CalculateAggroInvestmentResponse.fromJson(response.data?['calculateAgroInvestment'] ?? {});
  }

  Future<SaveAggroInvestmentResponse> saveAggroInvestment(SaveAggroInvestmentInput input) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.saveAggroInvestment(),
        ),
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return SaveAggroInvestmentResponse.fromJson(response.data?['saveAgroInvestment'] ?? {});
  }

  Future<SaveCorporateInvestmentResponse> saveCorporateInvestment(SaveCorporateInvestmentInput input) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.saveCorporateInvestment(),
        ),
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return SaveCorporateInvestmentResponse.fromJson(response.data?['saveCorporateInvestment'] ?? {});
  }
}
