import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class OnboardingDataSource {
  Future<OnboardingEntity> getOnboardingData({
    required GraphQLClient client,
    required String userId,
  });
}
