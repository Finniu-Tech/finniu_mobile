import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class OnboardingRepository {
  Future<OnboardingEntity> getOnboardingData({
    required GraphQLClient client,
    required String userId,
  });

  Future<OnboardingEntity> updateOnboardingData({
    required GraphQLClient client,
    required String userId,
    required String questionId,
    required String answerId,
  });
}
