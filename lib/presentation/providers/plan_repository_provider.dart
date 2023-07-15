import 'package:finniu/domain/repositories/plan_repository.dart';
import 'package:finniu/infrastructure/datasources/plan_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/plan_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final planRepositoryProvider = Provider<PlanRepository>(
  (ref) => PlanRepositoryImp(
    dataSource: PlanDataSourceImp(),
  ),
);
