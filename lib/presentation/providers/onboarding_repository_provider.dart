import 'package:finniu/domain/repositories/onboarding_repository.dart';
import 'package:finniu/infrastructure/datasources/onboarding_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/onboarding_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>(
  (ref) => OnboardingRepositoryImp(
    dataSource: OnboardingDataSourceImp(),
  ),
);
