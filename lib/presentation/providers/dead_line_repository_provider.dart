import 'package:finniu/infrastructure/datasources/dead_line_datasource_imp.dart';
import 'package:finniu/infrastructure/repositories/dead_line_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deadLineRepositoryProvider = Provider<DeadLineRepositoryImp>(
  (ref) => DeadLineRepositoryImp(
    dataSource: DeadLineDataSourceImp(),
  ),
);
