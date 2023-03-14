import 'package:finniu/infrastructure/datasources/onboarding_datasource_imp.dart';
import 'package:finniu/infrastructure/datasources/recovery_password_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/onboarding_repository_imp.dart';
import 'package:finniu/infrastructure/repositories/recovery_password_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final recoveryPasswordRepositoryProvider =
    Provider<RecoveryPasswordRepositoryImp>(
  (ref) => RecoveryPasswordRepositoryImp(
    dataSource: RecoveryPasswordDataSourceImp(),
  ),
);
