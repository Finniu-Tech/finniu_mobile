import 'package:finniu/domain/datasources/onboarding_datasource.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/domain/repositories/onboarding_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OnboardingRepositoryImp implements OnboardingRepository {
  final OnboardingDataSource dataSource;

  OnboardingRepositoryImp({required this.dataSource});

  @override
  Future<OnboardingEntity> getOnboardingData({
    required GraphQLClient client,
    required String userId,
  }) async {
    return await dataSource.getOnboardingData(client: client, userId: userId);
  }

  // @override
  // Future<void> saveOnboardingStatus(bool status) async {
  //   await dataSource.saveOnboardingStatus(status);
  // }

  // @override
  // Future<bool> getOnboardingStatus() async {
  //   return await dataSource.getOnboardingStatus();
  // }
}
