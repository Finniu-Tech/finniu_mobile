import 'package:finniu/infrastructure/datasources/calculate_investment_imp.dart';
import 'package:finniu/infrastructure/datasources/onboarding_datasource_imp.dart';
import 'package:finniu/infrastructure/datasources/recovery_password_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/calculate_investment_imp.dart';
import 'package:finniu/infrastructure/repositories/onboarding_repository_imp.dart';
import 'package:finniu/infrastructure/repositories/recovery_password_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final calculateInvestmentRepositoryProvider =
    Provider<CalculateInvestmentRepositoryImp>(
  (ref) => CalculateInvestmentRepositoryImp(
    dataSource: CalculateInvestmentDataSourceImp(),
  ),
);
