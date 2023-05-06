import 'package:finniu/infrastructure/datasources/bank_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/bank_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bankRepositoryProvider = Provider<BankRepositoryImp>(
  (ref) => BankRepositoryImp(
    dataSource: BankDataSourceImp(),
  ),
);
