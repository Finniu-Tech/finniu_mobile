import 'package:finniu/domain/datasources/onboarding_datasource.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/mappers/onboarding_mapper.dart';
import 'package:finniu/infrastructure/models/onboarding_mapper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OnboardingDataSourceImp extends OnboardingDataSource {
  @override
  Future<OnboardingEntity> getOnboardingData({
    required GraphQLClient client,
    required String userId,
  }) async {
    final response = client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.startOnboardingQuestions(),
        ),
        variables: {
          'user_id': userId,
        },
      ),
    );
    final responseGraphQL = StartOnboardingGraphqlModel.fromJson(
      (await response).data?['startOnboarding'],
    );
    return OnboardingMapper.toEntity(responseGraphQL);
  }
}
