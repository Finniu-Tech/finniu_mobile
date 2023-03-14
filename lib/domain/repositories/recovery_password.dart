import 'package:graphql_flutter/graphql_flutter.dart';

abstract class RecoveryPasswordRepository {
  Future<bool> sendEmailRecoveryPassword({
    required GraphQLClient client,
    required String email,
  });

  // Future<OnboardingEntity> updateOnboardingData({
  //   required GraphQLClient client,
  //   required String userId,
  //   required String questionId,
  //   required String answerId,
  // });

  // Future<PlanEntity> finishOnboarding({
  //   required GraphQLClient client,
  //   required String userId,
  // });
}
