import 'package:finniu/infrastructure/datasources/calculate_investment_imp.dart';
import 'package:finniu/infrastructure/repositories/calculate_investment_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final calculateInvestmentRepositoryProvider =
    Provider<CalculateInvestmentRepositoryImp>(
  (ref) => CalculateInvestmentRepositoryImp(
    dataSource: CalculateInvestmentDataSourceImp(),
  ),
);
