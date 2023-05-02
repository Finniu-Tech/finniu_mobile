import 'package:finniu/infrastructure/datasources/pre_investment_imp_datasource.dart';
import 'package:finniu/infrastructure/repositories/pre_investment_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final preInvestmentRepositoryProvider = Provider<PreInvestmentRepositoryImp>(
  (ref) => PreInvestmentRepositoryImp(
    dataSource: PreInvestmentDataSourceImp(),
  ),
);
